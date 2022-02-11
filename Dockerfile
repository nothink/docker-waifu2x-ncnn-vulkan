FROM debian:bullseye-slim as base

RUN --mount=type=cache,target=/var/cache \
    --mount=type=cache,target=/var/lib/apt/lists/ \
    apt-get update \
 && apt-get install -y \
        libvulkan1 \
        libgomp1

# ----------------------------------------------------------------------------
FROM base as builder

RUN --mount=type=cache,target=/var/cache \
    --mount=type=cache,target=/var/lib/apt/lists/ \
    apt-get install -y \
        git \
        build-essential \
        cmake \
        ninja-build \
        libvulkan-dev

RUN cd / \
 && git clone  https://github.com/nihui/waifu2x-ncnn-vulkan.git waifu2x \
 && cd /waifu2x \
 && git submodule update --init --recursive

RUN mkdir /waifu2x/build \
 && cd /waifu2x/build \
 && cmake -GNinja /waifu2x/src \
 && ninja

# ----------------------------------------------------------------------------
FROM base as production

WORKDIR /tmp

COPY --from=builder /waifu2x/models /usr/local/bin
COPY --from=builder /waifu2x/build/waifu2x-ncnn-vulkan /usr/local/bin/waifu2x-ncnn-vulkan

RUN ln -sf /usr/local/bin/waifu2x-ncnn-vulkan /usr/local/bin/waifu2x

ENTRYPOINT [ "/usr/local/bin/waifu2x-ncnn-vulkan" ]
CMD [ "-h" ]
