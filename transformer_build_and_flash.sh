#!/bin/sh
./scripts/transformer_build_kernel.sh \
	&& ./scripts/transformer_assemble_kernel_blob.sh \
	&& ./scripts/transformer_flash_kernel_blob.sh
