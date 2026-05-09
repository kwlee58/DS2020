## ---------------------------------------------------------------
## sejong_helpers_v3.R
##
## 11주차 "세종대왕 세법개혁 국민투표" 시각화 헬퍼.
##
## v2 와의 차이
##   1) KoPubWorld 폰트 의존성 제거 → showtext + Google Fonts 의 Nanum Gothic
##   2) theme_set() 으로 전역 테마(나눔고딕 + 가운데 굵은 제목)를 한 번만 설정
##   3) update_geom_defaults() 로 geom_text 의 기본 폰트도 나눔고딕으로
##   4) 헬퍼 함수 본문에서 family/theme_sejong 인자가 사라져 한층 짧아짐
##
## Rmd 첫 setup 청크에서  source("sejong_helpers_v3.R")  한 줄로 끝.
## ---------------------------------------------------------------

suppressPackageStartupMessages({
  library(ggplot2)
  library(grid)
  library(gridExtra)
  library(dplyr)
  library(showtext)
  library(sysfonts)
})

## --- 1. 한글 폰트 ---------------------------------------------
##  Google Fonts 의 Nanum Gothic 을 가져와 "nanum" 패밀리로 등록.
##  최초 1회 인터넷 다운로드, 이후 sysfonts 캐시에서 즉시 로드.

if (!"nanum" %in% sysfonts::font_families()) {
  sysfonts::font_add_google("Nanum Gothic", "nanum")
}
showtext::showtext_auto()

## --- 2. 전역 테마 ---------------------------------------------
##  모든 ggplot 출력의 기본 = theme_bw + 나눔고딕 + 가운데 굵은 제목.
##  Rmd 본문에서는 그래프마다 theme_*() 를 또 부를 필요가 없다.

theme_set(
  theme_bw(base_family = "nanum") +
    theme(plot.title = element_text(hjust = 0.5, size = 18, face = "bold"))
)

##  geom_text 의 기본 폰트도 나눔고딕으로 (개별 family= 인자 불필요)
update_geom_defaults("text", list(family = "nanum"))

##  v2 와의 호환을 위한 빈 별칭 — 옛 Rmd 에서 + theme_sejong() 호출이 있어도 무해.
theme_sejong <- function(base_size = 12) {
  theme_bw(base_size = base_size, base_family = "nanum") +
    theme(plot.title = element_text(hjust = 0.5, size = 18, face = "bold"))
}

## --- 3. 라벨 위치 계산 -----------------------------------------
##  cumsum(x) - x/2  : 막대 안에서 라벨을 가운데에 둔다.

pos <- function(x) cumsum(x) - x / 2

## --- 4. 찬반 색상 ---------------------------------------------
##  rainbow(2)[2:1]  : 반대 = 빨강, 찬성 = 청록.

fill_vote <- function(name = "찬반") {
  scale_fill_manual(name = name, values = rainbow(2)[2:1])
}

## --- 5. 원형그래프 --------------------------------------------
##  df : 두 컬럼 데이터프레임 (Vote, Counts).

pie_vote <- function(df, title = "") {
  v   <- df[[1]]
  cnt <- df[[2]]
  y   <- pos(cnt)
  lbl <- paste(levels(v), format(cnt, big.mark = ","), sep = "\n")

  ggplot(df, aes(x = "", y = cnt, fill = v)) +
    geom_bar(width = 1, stat = "identity",
             position = position_stack(reverse = TRUE)) +
    geom_text(aes(y = y), label = lbl, size = 5) +
    coord_polar(theta = "y", start = 3 * pi / 2, direction = -1) +
    fill_vote() +
    guides(fill = "none") +
    theme_void(base_family = "nanum") +
    ggtitle(title) +
    theme(plot.title = element_text(hjust = 0.5, size = 18, face = "bold"),
          plot.margin = unit(c(1, 1, 1, 1), "lines"))
}

## --- 6. 막대그래프 --------------------------------------------
##  df : 세 컬럼 데이터프레임 (Vote, X, Counts).
##  position : "stack" / "dodge" / "fill".

bar_vote <- function(df,
                     position = c("stack", "dodge", "fill"),
                     xlab = "", ylab = "집계", title = "") {

  position <- match.arg(position)
  v   <- df[[1]]
  x   <- df[[2]]
  cnt <- df[[3]]

  if (position == "stack") {
    y_lab    <- unlist(tapply(cnt, x, function(z) cumsum(z) - z / 2))
    y_breaks <- unlist(tapply(cnt, x, cumsum))
    delta    <- diff(range(y_breaks)) / 20
    y_sorted <- sort(y_breaks)
    keep     <- which(diff(y_sorted) > delta)
    y_breaks <- c(0, y_sorted[c(keep, length(y_sorted))])
    y_label  <- format(y_breaks, big.mark = ",")
    geom_pos <- position_stack(reverse = TRUE)
    text_y   <- y_lab
    text_pos <- "identity"
    y_scale  <- scale_y_continuous(name = ylab,
                                   breaks = y_breaks, labels = y_label)
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
    geom_text(aes(y = text_y), label = lbl, position = text_pos) +
    scale_x_discrete(name = xlab) +
    y_scale +
    fill_vote() +
    ggtitle(title)
}

## --- 7. 모자이크 그래프 ---------------------------------------
##  df : 세 컬럼 데이터프레임 (Vote, X, Counts).

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

  g_sum    <- tapply(p_df$Prop, p_df[[2]], sum)
  x_breaks <- c(0, ifelse(cumsum(g_sum) < 0.1, 0.0, cumsum(g_sum)))
  x_label  <- format(x_breaks * 100, digits = 3, nsmall = 1)

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
    geom_text(aes(x = center, y = 1.05), label = p_df[[2]]) +
    geom_text(aes(x = center, y = label_height),
              label = cnt_lbl, position = position_identity()) +
    scale_x_continuous(name = xlab,
                       breaks = x_breaks, labels = x_label) +
    scale_y_continuous(name = ylab,
                       breaks = y_breaks, labels = y_label) +
    fill_vote() +
    ggtitle(title) +
    theme(plot.margin = unit(c(1, 2, 1, 1), "lines"))
}
