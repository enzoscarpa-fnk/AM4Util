<script setup>
import { ref, computed } from 'vue'

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
  <div class="bg-stone-800 rounded-xl shadow-md p-3">
    <div class="flex justify-between items-center">
      <h2 class="text-xl font-bold text-emerald-500 mb-2">Ticket price calculator</h2>

      <!-- Clear button -->
      <button
        @click="clearForm"
        class="w-7 h-7 flex items-center justify-center bg-rose-500 text-white rounded-full hover:bg-rose-600 transition-colors text-lg font-bold mb-2"
        title="Clear"
      >
        ×
      </button>
    </div>

    <!-- Base prices -->
    <div class="space-y-3">
      <div v-for="(label, key) in {
        baseYPrice: 'Base Price - Y Class (Economy)',
        baseJPrice: 'Base Price - J Class (Business)',
        baseFPrice: 'Base Price - F Class (First)'
      }" :key="key">
        <label class="block text-sm font-medium text-emerald-500">{{ label }}</label>
        <input
          type="text"
          v-model="fields[key].value"
          @input="filterInteger(fields[key])"
          maxlength="5"
          class="w-full px-3 py-1 border border-emerald-300 rounded-md focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 text-neutral-300"
          placeholder="0"
        />
      </div>

      <!-- Calculated prices -->
      <div class="px-2 bg-neutral-700 rounded-md">
        <div class="grid grid-cols-3 gap-4 py-2">
          <div class="text-center">
            <p class="text-xs text-gray-400 pb-1">Y Class</p>
            <p class="w-24 mx-auto text-lg font-semibold text-emerald-600 bg-neutral-600 rounded-md">$ {{ calculatedYPrice }}</p>
          </div>
          <div class="text-center">
            <p class="text-xs text-gray-400 pb-1">J Class</p>
            <p class="w-24 mx-auto text-lg font-semibold text-emerald-600 bg-neutral-600 rounded-md">$ {{ calculatedJPrice }}</p>
          </div>
          <div class="text-center">
            <p class="text-xs text-gray-400 pb-1">F Class</p>
            <p class="w-24 mx-auto text-lg font-semibold text-emerald-600 bg-neutral-600 rounded-md">$ {{ calculatedFPrice }}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
