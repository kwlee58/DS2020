## ---------------------------------------------------------------
## sejong_helpers.R
##
## 11주차 "세종대왕 세법개혁 국민투표" 시각화에서 반복되는
## - 라벨 위치 계산
## - 한글 글꼴 테마
## - 찬반 색상
## - 원형 / 막대 / 모자이크 그래프 함수
## 를 한 곳에 모은 도우미 파일.
##
## Rmd 첫 setup 청크에서  source("sejong_helpers.R") 로 불러서 사용.
## ---------------------------------------------------------------

suppressPackageStartupMessages({
  library(ggplot2)
  library(grid)
  library(gridExtra)
  library(dplyr)
})

## --- 1. 누적 라벨 위치 계산 -------------------------------------
##  cumsum(x) - x/2  : 막대 안에서 라벨이 가운데 오도록.

pos <- function(x) cumsum(x) - x / 2

## --- 2. 한글 테마와 찬반 색상 ----------------------------------
##  KoPubWorldDotum 폰트가 시스템에 등록되어 있다고 가정.
##  base_size 만 인자로 받고 나머지는 일관 적용.

theme_sejong <- function(base_size = 12) {
  theme_bw(base_size = base_size,
           base_family = "KoPubWorldDotum Medium") +
    theme(plot.title = element_text(hjust = 0.5,
                                    size = 18,
                                    family = "KoPubWorldDotum Bold"))
}

##  찬성/반대 두 수준 색상 (rainbow(2)[2:1] 와 동일)
##  scale_fill_manual() 객체를 그대로 + 로 더할 수 있도록 반환.

fill_vote <- function(name = "찬반") {
  scale_fill_manual(name = name, values = rainbow(2)[2:1])
}

## --- 3. 원형그래프 ---------------------------------------------
##  df : 두 컬럼 데이터프레임 ( Vote, Counts ) 또는 동등한 구조.
##       첫 컬럼이 factor(찬반), 두 번째 컬럼이 집계.

pie_vote <- function(df, title = "") {
  v   <- df[[1]]                       # factor (찬반)
  cnt <- df[[2]]                       # numeric (집계)
  y   <- pos(cnt)                      # 라벨 y 위치
  lbl <- paste(levels(v),
               format(cnt, big.mark = ","),
               sep = "\n")

  ggplot(df, aes(x = "", y = cnt, fill = v)) +
    geom_bar(width = 1, stat = "identity",
             position = position_stack(reverse = TRUE)) +
    geom_text(aes(y = y), label = lbl, size = 5,
              family = "KoPubWorldDotum Medium") +
    coord_polar(theta = "y", start = 3 * pi / 2, direction = -1) +
    fill_vote() +
    guides(fill = "none") +
    theme_void(base_family = "KoPubWorldDotum Medium") +
    ggtitle(title) +
    theme(plot.title = element_text(hjust = 0.5, size = 18,
                                    family = "KoPubWorldDotum Bold"),
          plot.margin = unit(c(1, 1, 1, 1), "lines"))
}

## --- 4. 막대그래프 ---------------------------------------------
##  df : 세 컬럼 데이터프레임 ( Vote, X, Counts )
##       1) Vote  : factor (찬반)
##       2) X     : factor (계급, 지역 등 가로축)
##       3) Counts: numeric (집계)
##  position : "stack", "dodge", "fill" 중 선택.

bar_vote <- function(df,
                     position = c("stack", "dodge", "fill"),
                     xlab = "", ylab = "집계",
                     title = "") {

  position <- match.arg(position)
  v   <- df[[1]]
  x   <- df[[2]]
  cnt <- df[[3]]

  ## y 좌표(라벨 위치)와 break/label 을 position 별로 계산
  if (position == "stack") {
    y_lab    <- unlist(tapply(cnt, x, function(z) cumsum(z) - z / 2))
    y_breaks <- unlist(tapply(cnt, x, cumsum))
    ## breaks 가 너무 빽빽해지지 않도록 솎아냄
    delta    <- diff(range(y_breaks)) / 20
    y_sorted <- sort(y_breaks)
    keep     <- which(diff(y_sorted) > delta)
    y_breaks <- c(0, y_sorted[c(keep, length(y_sorted))])
    y_label  <- format(y_breaks, big.mark = ",")
    geom_pos <- position_stack(reverse = TRUE)
    text_y   <- y_lab
    text_pos <- "identity"
    y_scale  <- scale_y_continuous(name = ylab,
                                   breaks = y_breaks,
                                   labels = y_label)
  } else if (position == "dodge") {
    text_y   <- cnt / 2
    geom_pos <- position_dodge(width = 0.9)
    text_pos <- position_dodge(width = 0.9)
    y_scale  <- scale_y_continuous(name = ylab,
                                   labels = function(z) format(z, big.mark = ","))
  } else {  ## "fill"
    y_fill   <- unlist(tapply(cnt, x, function(z) cumsum(z) / sum(z)))
    text_y   <- unlist(tapply(cnt, x,
                              function(z) (cumsum(z) - z / 2) / sum(z)))
    geom_pos <- position_fill(reverse = TRUE)
    text_pos <- "identity"
    y_scale  <- scale_y_continuous(name = ylab,
                                   breaks = y_fill,
                                   labels = format(y_fill * 100,
                                                   digits = 2, nsmall = 1))
  }

  lbl <- ifelse(cnt == 0, "", format(cnt, big.mark = ","))

  ggplot(df, aes(x = x, y = cnt, fill = v)) +
    geom_bar(stat = "identity", position = geom_pos) +
    geom_text(aes(y = text_y), label = lbl,
              position = text_pos,
              family = "KoPubWorldDotum Medium") +
    scale_x_discrete(name = xlab) +
    y_scale +
    fill_vote() +
    theme_sejong() +
    ggtitle(title)
}

## --- 5. 모자이크 그래프 ----------------------------------------
##  df : 세 컬럼 데이터프레임 ( Vote, X, Counts ).
##  X 그룹별 비중에 비례하는 너비, 그룹 안의 찬반 비율로 높이.

mosaic_vote <- function(df,
                        xlab = "(누적 %)", ylab = "찬반(%)",
                        title = "") {

  v_levels <- levels(df[[1]])
  N        <- length(v_levels)

  p_df <- df
  p_df$Prop <- df[[3]] / sum(df[[3]])
  p_df$width <- rep(tapply(p_df$Prop, p_df[[2]], sum), each = N)
  p_df$height <- unlist(tapply(p_df$Prop, p_df[[2]], proportions))
  p_df$label_height <- unlist(tapply(p_df$height, p_df[[2]],
                                     function(z) cumsum(z) - z / 2))
  p_df$y_breaks <- unlist(tapply(p_df$height, p_df[[2]], cumsum))
  p_df$center  <- rep(pos(tapply(p_df$Prop, p_df[[2]], sum)), each = N)

  ## x 축 눈금 (그룹 누적 %)
  g_sum    <- tapply(p_df$Prop, p_df[[2]], sum)
  x_breaks <- c(0, ifelse(cumsum(g_sum) < 0.1, 0.0, cumsum(g_sum)))
  x_label  <- format(x_breaks * 100, digits = 3, nsmall = 1)

  ## y 축 눈금 솎아내기
  delta    <- diff(range(p_df$y_breaks)) / 20
  ys       <- sort(p_df$y_breaks)
  keep     <- which(diff(ys) > delta)
  y_breaks <- c(0, ys[c(keep, length(ys))])
  y_label  <- format(y_breaks * 100, digits = 2, nsmall = 1)

  cnt_lbl <- ifelse(df[[3]] == 0, "", format(df[[3]], big.mark = ","))

  ggplot(p_df, aes(x = center, y = height, width = width)) +
    geom_bar(aes(fill = p_df[[1]]),
             stat = "identity", col = "white", linewidth = 1,
             position = position_stack(reverse = TRUE)) +
    geom_text(aes(x = center, y = 1.05),
              family = "KoPubWorldDotum Medium",
              label = p_df[[2]]) +
    geom_text(aes(x = center, y = label_height),
              label = cnt_lbl,
              family = "KoPubWorldDotum Medium",
              position = position_identity()) +
    scale_x_continuous(name = xlab,
                       breaks = x_breaks, labels = x_label) +
    scale_y_continuous(name = ylab,
                       breaks = y_breaks, labels = y_label) +
    fill_vote() +
    theme_sejong() +
    ggtitle(title) +
    theme(plot.margin = unit(c(1, 2, 1, 1), "lines"))
}
