# docker-waifu2x-ncnn-vulkan
Docker container of [nihui/waifu2x-ncnn-vulkan](https://github.com/nihui/waifu2x-ncnn-vulkan).

(still beta, and CPU only)

## usage

```fish
❯ docker run --rm -it nothink/waifu2x-ncnn-vulkan
Usage: waifu2x-ncnn-vulkan -i infile -o outfile [options]...

  -h                   show this help
  -v                   verbose output
  -i input-path        input image path (jpg/png/webp) or directory
  -o output-path       output image path (jpg/png/webp) or directory
  -n noise-level       denoise level (-1/0/1/2/3, default=0)
  -s scale             upscale ratio (1/2/4/8/16/32, default=2)
  -t tile-size         tile size (>=32/0=auto, default=0) can be 0,0,0 for multi-gpu
  -m model-path        waifu2x model path (default=models-cunet)
  -g gpu-id            gpu device to use (-1=cpu, default=auto) can be 0,1,2 for multi-gpu
  -j load:proc:save    thread count for load/proc/save (default=1:2:2) can be 1:2,2,2:2 for multi-gpu
  -x                   enable tta mode
  -f format            output image format (jpg/png/webp, default=ext/png)

```

using with fish:

```fish
❯ docker run --rm -v (pwd):/tmp -it nothink/waifu2x-ncnn-vulkan -i /tmp/input.jpg -o /tmp/output.jpg
```


using with bash/zsh:

```bash
$ docker run --rm -v `pwd`:/tmp -it nothink/waifu2x-ncnn-vulkan -i /tmp/input.jpg -o /tmp/output.jpg
```
