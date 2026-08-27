<script setup lang="ts">
import type InputForm from '@/types'
import {
  CalendarDaysIcon,
  HeadingIcon,
  IdCardIcon,
  IdCardLanyardIcon,
  NotebookTextIcon,
  type LucideIcon,
} from '@lucide/vue'
import { computed } from 'vue'

const inputs = defineModel<InputForm>('inputs', {
  required: true,
})
const emit = defineEmits<{
  download: []
  togglePreview: []
}>()

interface SidebarInput {
  icon: LucideIcon
  title: string
  key: keyof InputForm
}

const fields: SidebarInput[] = [
  {
    icon: HeadingIcon,
    title: 'Name',
    key: 'name',
  },
  {
    icon: IdCardIcon,
    title: 'Roll Number',
    key: 'id',
  },
  {
    icon: CalendarDaysIcon,
    title: 'Semester',
    key: 'semester',
  },
  {
    icon: NotebookTextIcon,
    title: 'Subject',
    key: 'subject',
  },
  {
    icon: HeadingIcon,
    title: 'Title',
    key: 'title',
  },
  {
    icon: IdCardLanyardIcon,
    title: 'Principal',
    key: 'principal',
  },
  {
    icon: IdCardLanyardIcon,
    title: 'Professor',
    key: 'professor',
  },
]
const hasBadInput = computed(() =>
  fields.some((field) => inputs.value[field.key].trim().length === 0),
)
</script>

<template>
  <div class="h-full w-full lg:p-4 lg:w-lg">
    <div
      class="w-full h-full flex flex-col space-y-2 p-4 rounded-lg border shadow-xl bg-gray-50 dark:bg-gray-950 border-gray-300 dark:border-gray-900"
    >
      <div v-for="field in fields" class="flex flex-col space-y-2">
        <p class="px-1 text-sm">{{ field.title }}</p>
        <div class="flex relative items-center text-gray-700 dark:text-gray-300">
          <component :is="field.icon" class="absolute size-6 text-inherit mx-3" />
          <input
            v-model="inputs[field.key]"
            :class="inputs[field.key].trim().length === 0 ? 'not-focus:outline-red-500!' : ''"
            :placeholder="field.title"
            type="text"
            class="py-3 px-11 w-full border rounded-lg text-inherit bg-gray-100 dark:bg-gray-900 border-gray-200 dark:border-gray-800 outline-2 outline-transparent focus:outline-blue-400 focus:dark:outline-blue-600"
          />
        </div>
      </div>

      <div class="flex mt-auto sm:flex-row sm:space-x-2 not-sm:flex-col not-sm:space-y-2">
        <!-- TODO: handle this better than whatever this is -->
        <!-- <button
          class="w-full p-3 lg:hidden bg-gray-700 dark:bg-gray-400"
          type="button"
          @click="emit('togglePreview')"
        >
          Preview
        </button> -->
        <button
          class="w-full p-3 disabled:bg-blue-300 disabled:dark:bg-blue-900"
          type="button"
          @click="emit('download')"
          :disabled="hasBadInput"
        >
          Download
        </button>
      </div>
    </div>
  </div>
</template>
