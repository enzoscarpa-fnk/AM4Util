<script setup>
import { ref, computed, defineProps, defineEmits } from 'vue'

const props = defineProps({
  isOpen: {
    type: Boolean,
    default: true
  }
})

const emit = defineEmits(['toggle'])

const baseYPrice = ref('')
const baseJPrice = ref('')
const baseFPrice = ref('')

const fields = {
  baseYPrice,
  baseJPrice,
  baseFPrice
}

const toNumber = (val) => Number(val) || 0

const calculatedYPrice = computed(() => {
  const base = toNumber(baseYPrice.value)
  return Math.floor(base * 1.1)
})

const calculatedJPrice = computed(() => {
  const base = toNumber(baseJPrice.value)
  return Math.floor(base * 1.08)
})

const calculatedFPrice = computed(() => {
  const base = toNumber(baseFPrice.value)
  return Math.floor(base * 1.06)
})

const hasResults = computed(() => {
  return baseYPrice.value || baseJPrice.value || baseFPrice.value
})

const clearForm = () => {
  baseYPrice.value = ''
  baseJPrice.value = ''
  baseFPrice.value = ''
}

const filterInteger = (field) => {
  field.value = field.value.replace(/\D/g, '')
}
</script>

<template>
  <div class="bg-stone-800 rounded-xl shadow-md overflow-hidden">
    <!-- Header cliquable -->
    <div
      @click="emit('toggle')"
      class="flex justify-between items-center p-3 cursor-pointer hover:bg-stone-700 transition-colors"
    >
      <h2 class="text-xl font-bold text-emerald-500">Ticket Price Calculator</h2>

      <!-- Chevron + Clear button -->
      <div class="flex items-center gap-2">
        <button
          v-if="isOpen && hasResults"
          @click.stop="clearForm"
          class="w-7 h-7 flex items-center justify-center bg-rose-500 text-white rounded-full hover:bg-rose-600 transition-colors text-lg font-bold"
          title="Clear"
        >
          ×
        </button>

        <svg
          class="w-5 h-5 text-emerald-500 transition-transform"
          :class="{ 'rotate-180': isOpen }"
          fill="none"
          stroke="currentColor"
          viewBox="0 0 24 24"
        >
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
        </svg>
      </div>
    </div>

    <!-- Contenu des inputs (masqué quand fermé) -->
    <Transition
      enter-active-class="transition-all duration-200 ease-out"
      enter-from-class="max-h-0 opacity-0"
      enter-to-class="max-h-96 opacity-100"
      leave-active-class="transition-all duration-200 ease-in"
      leave-from-class="max-h-96 opacity-100"
      leave-to-class="max-h-0 opacity-0"
    >
      <div v-if="isOpen" class="px-3 pb-3 space-y-3">
        <!-- Base prices inputs -->
        <div v-for="(label, key) in {
          baseYPrice: 'Base Price - Y Class (Economy)',
          baseJPrice: 'Base Price - J Class (Business)',
          baseFPrice: 'Base Price - F Class (First)'
        }" :key="key">
          <label class="block pb-1 text-sm font-medium text-emerald-500">{{ label }}</label>
          <input
            type="text"
            v-model="fields[key].value"
            @input="filterInteger(fields[key])"
            maxlength="5"
            class="w-full px-3 py-1 border border-emerald-300 rounded-md focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 text-neutral-300"
            placeholder="0"
          />
        </div>
      </div>
    </Transition>

    <!-- Résultats calculés (TOUJOURS VISIBLES si hasResults) -->
    <div v-if="hasResults" class="px-3 pb-3">
      <div class="px-2 bg-neutral-700 rounded-md">
        <div class="grid grid-cols-3 gap-4 py-2">
          <div class="text-center">
            <p class="text-xs text-gray-400 pb-1">Y Class</p>
            <p class="w-24 mx-auto text-lg font-semibold text-emerald-500 bg-neutral-600 rounded-md">$ {{ calculatedYPrice }}</p>
          </div>
          <div class="text-center">
            <p class="text-xs text-gray-400 pb-1">J Class</p>
            <p class="w-24 mx-auto text-lg font-semibold text-emerald-500 bg-neutral-600 rounded-md">$ {{ calculatedJPrice }}</p>
          </div>
          <div class="text-center">
            <p class="text-xs text-gray-400 pb-1">F Class</p>
            <p class="w-24 mx-auto text-lg font-semibold text-emerald-500 bg-neutral-600 rounded-md">$ {{ calculatedFPrice }}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
