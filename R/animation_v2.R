library(animation)
my_animation <- function() {
  n <- 100
  for (i in 1:n) {
    x <- rnorm(10)
    y <- rnorm(10)
    plot(x, y, xlim = c(-3, 3), ylim = c(-3, 3))
    text(0, 2.5, paste("Frame", i))
    ani.pause(0.1)
    ani.record()
  }
}
saveVideo(my_animation(), video.name = "./pics/my_animation.mp4", fps = 10, codec = "libx264")

saveGIF({
  for (i in 1:10) {
    plot(runif(10), ylim = c(0,1))
    Sys.sleep(0.5)
  }
}, movie.name = "example.gif")

# save the animation as PNG files
saveHTML({
  for (i in 1:10) {
    plot(runif(10), ylim = c(0,1))
    Sys.sleep(0.5)
  }
}, imgdir = "./pics/example_frames", imgtype = "png")
