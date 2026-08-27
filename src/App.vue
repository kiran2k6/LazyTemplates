<script setup lang="ts">
import { reactive, ref, watch } from 'vue'
import ConfigPanel from './components/ConfigPanel.vue'
import PagePreview from './components/PagePreview.vue'
import type InputForm from './types'

const DATASTORE_KEY = 'InputFormData'
const DEFAULT_INPUTS = {
  name: '',
  id: '',
  semester: '',
  subject: '',
  title: '',
  principal: '',
  professor: '',
}

const storedInputs = localStorage.getItem(DATASTORE_KEY)
const preview = ref<InstanceType<typeof PagePreview>>()
const inputs = reactive<InputForm>(
  storedInputs ? { ...DEFAULT_INPUTS, ...JSON.parse(storedInputs) } : DEFAULT_INPUTS
)
const showPreview = ref(false)

watch(
  () => inputs,
  (it) => {
    localStorage.setItem(DATASTORE_KEY, JSON.stringify(it))
  },
  {
    deep: true
  }
)

async function download() {
  preview.value?.download()
}
</script>

<template>
  <div class="flex flex-row h-dvh w-full">
    <ConfigPanel
      v-model:inputs="inputs"
      @togglePreview="showPreview = !showPreview"
      @download="download"
    />
    <div
      :class="[!showPreview && 'max-lg:hidden']"
      class="min-w-0 lg:relative lg:flex-1 max-lg:fixed max-lg:inset-0 max-lg:z-10"
    >
      <PagePreview :inputs="inputs" ref="preview" />
    </div>
  </div>
</template>
