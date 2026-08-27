<script setup lang="ts">
import { onMounted, ref, watch } from 'vue'

import compilerWasm from '@myriaddreamin/typst-ts-web-compiler/pkg/typst_ts_web_compiler_bg.wasm?url'
import rendererWasm from '@myriaddreamin/typst-ts-renderer/pkg/typst_ts_renderer_bg.wasm?url'
import { $typst } from '@myriaddreamin/typst.ts/dist/esm/contrib/snippet.mjs'
import { loadFonts } from '@myriaddreamin/typst.ts/dist/esm/options.init'

import SOURCE from '@/template.typ?raw'
import PLEX_REGULAR from '@/fonts/regular.ttf?url'
import PLEX_BOLD from '@/fonts/bold.ttf?url'
import LOGO from '@/logo.webp?url'
import type InputForm from '@/types'

const renderTarget = ref<HTMLElement | null>(null)
const props = defineProps<{
  inputs: InputForm
}>()
defineExpose({
  download
})

function getInput() {
  return {
    mainContent: SOURCE,
    inputs: {
      title: props.inputs.title,
      name: props.inputs.name,
      id: props.inputs.id,
      semester: props.inputs.semester,
      subject: props.inputs.subject,
      professor: props.inputs.professor,
      principal: props.inputs.principal
    },
  }
}

// really?
async function download() {
  // some ridiculous cast to a BlobPart
  const pdf = await $typst.pdf(getInput()) as BlobPart
  const blob = new Blob([pdf], { type: 'application/pdf' })
  const url = URL.createObjectURL(blob)
  const a = document.createElement('a')
  a.href = url
  a.download = `${props.inputs.name}'s ${props.inputs.subject} ${props.inputs.title}.pdf`
  a.click()
  URL.revokeObjectURL(url)
}

async function importAssets() {
  const logoResponse = await fetch(LOGO)
  const logoData = new Uint8Array(await logoResponse.arrayBuffer())
  await $typst.mapShadow('/logo.webp', logoData)
}

async function render() {
  try {
    const output = await $typst.svg(getInput())
    if (renderTarget.value) {
      renderTarget.value.innerHTML = output
    }
  } catch (e) {
    console.error(e)
  }
}

watch(
  () => props.inputs,
  async () => {
    await render()
  },
  {
    deep: true,
  },
)

onMounted(async () => {
  $typst.setCompilerInitOptions({
    getModule: () => compilerWasm,
    beforeBuild: [loadFonts([PLEX_REGULAR, PLEX_BOLD])],
  })
  $typst.setRendererInitOptions({
    getModule: () => rendererWasm,
  })
  await importAssets()
  await render()
})
</script>

<template>
  <div class="flex p-8 w-full justify-center">
     <div ref="renderTarget" id="render" class="shadow-2xl bg-white aspect-210/297" />
  </div>
</template>
