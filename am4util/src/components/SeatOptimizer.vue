<script setup>
import { ref, computed } from 'vue'

const demandY = ref('')
const demandJ = ref('')
const demandF = ref('')
const planeSeats = ref('')

const fields = {
  demandY,
  demandJ,
  demandF,
  planeSeats
}

const toNumber = (val) => Number(val) || 0

const totalSeats = computed(() => {
  const y = toNumber(demandY.value)
  const j = toNumber(demandJ.value)
  const f = toNumber(demandF.value)
  return y + (j * 2) + (f * 3)
})

const ySeats = computed(() => {
  const total = totalSeats.value
  const seats = toNumber(planeSeats.value)
  if (total === 0 || seats === 0) return 0
  return Math.round((toNumber(demandY.value) * seats) / total)
})

const jSeats = computed(() => {
  const total = totalSeats.value
  const seats = toNumber(planeSeats.value)
  if (total === 0 || seats === 0) return 0
  return Math.round((toNumber(demandJ.value) * seats) / total)
})

const fSeats = computed(() => {
  const total = totalSeats.value
  const seats = toNumber(planeSeats.value)
  if (total === 0 || seats === 0) return 0
  return Math.round((toNumber(demandF.value) * seats) / total)
})

const clearForm = () => {
  demandY.value = ''
  demandJ.value = ''
  demandF.value = ''
  planeSeats.value = ''
}

const filterInteger = (field) => {
  field.value = field.value.replace(/\D/g, '')
}
</script>

<template>
  <div class="bg-stone-800 rounded-xl shadow-md p-3">
    <div class="flex justify-between items-center">
      <h2 class="text-xl font-bold text-emerald-500 mb-2">Seats optimizer</h2>

      <!-- Clear button -->
      <button
        @click="clearForm"
        class="w-7 h-7 flex items-center justify-center bg-rose-500 text-white rounded-full hover:bg-rose-600 transition-colors text-lg font-bold mb-2"
        title="Clear"
      >
        ×
      </button>
    </div>

    <!-- Passengers demand -->
    <div class="space-y-3">
      <div v-for="(label, key) in {
        demandY: 'Demand - Y Class (Economy)',
        demandJ: 'Demand - J Class (Business)',
        demandF: 'Demand - F Class (First)',
        planeSeats: 'Total number of seats in the plane'
      }" :key="key">
        <label class="block text-sm font-medium text-emerald-500">{{ label }}</label>
        <input
          type="text"
          v-model="fields[key].value"
          @input="filterInteger(fields[key])"
          class="w-full px-3 py-1 border border-emerald-300 rounded-md focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 text-neutral-300"
          placeholder="0"
        />
      </div>

      <!-- Breakdown -->
      <div class="px-2 bg-neutral-700 rounded-md">
        <h3 class="font-semibold text-emerald-500 mb-2 pt-1 text-center">Breakdown</h3>
        <div class="grid grid-cols-3 gap-4">
          <div class="text-center">
            <p class="text-xs text-gray-400">Y Seats</p>
            <p class="text-lg font-semibold text-emerald-600">{{ ySeats }}</p>
          </div>
          <div class="text-center">
            <p class="text-xs text-gray-400">J Seats</p>
            <p class="text-lg font-semibold text-emerald-600">{{ jSeats }}</p>
          </div>
          <div class="text-center">
            <p class="text-xs text-gray-400">F Seats</p>
            <p class="text-lg font-semibold text-emerald-600">{{ fSeats }}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
