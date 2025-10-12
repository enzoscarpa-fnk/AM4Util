<script setup>
import { ref, computed } from 'vue'

const demandY = ref(0)
const demandJ = ref(0)
const demandF = ref(0)
const planeSeats = ref(0)

const totalSeats = computed(() => demandY.value + (demandJ.value * 2) + (demandF.value * 3))

const ySeats = computed(() => {
  if (totalSeats.value === 0) return 0
  return (demandY.value * planeSeats.value) / totalSeats.value
})

const jSeats = computed(() => {
  if (totalSeats.value === 0) return 0
  return (demandJ.value * planeSeats.value) / totalSeats.value
})

const fSeats = computed(() => {
  if (totalSeats.value === 0) return 0
  return (demandF.value * planeSeats.value) / totalSeats.value
})

const clearForm = () => {
  demandY.value = 0
  demandJ.value = 0
  demandF.value = 0
  planeSeats.value = 0
}
</script>

<template>
  <div class="bg-stone-800 rounded-xl shadow-md p-3">
    <div class="flex justify-between items-center">
      <h2 class="text-xl font-bold text-emerald-500 mb-2">Seats optimizer</h2>

      <!-- Bouton Clear -->
      <button
        @click="clearForm"
        class="w-7 h-7 flex items-center justify-center bg-rose-500 text-white rounded-full hover:bg-rose-600 transition-colors text-lg font-bold mb-2"
        title="Clear"
      >
        ×
      </button>
    </div>

    <div class="space-y-3">
      <!-- Demande passagers Y -->
      <div>
        <label class="block text-sm font-medium text-emerald-500">
          Demand - Y Class (Economy)
        </label>
        <input
          type="number"
          v-model.number="demandY"
          class="w-full px-3 py-1 border border-emerald-300 rounded-md focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 text-neutral-300"
          placeholder="0"
        />
      </div>

      <!-- Demande passagers J -->
      <div>
        <label class="block text-sm font-medium text-emerald-500">
          Demand - J Class (Business)
        </label>
        <input
          type="number"
          v-model.number="demandJ"
          class="w-full px-3 py-1 border border-emerald-300 rounded-md focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 text-neutral-300"
          placeholder="0"
        />
      </div>

      <!-- Demande passagers F -->
      <div>
        <label class="block text-sm font-medium text-emerald-500">
          Demand - F Class (First)
        </label>
        <input
          type="number"
          v-model.number="demandF"
          class="w-full px-3 py-1 border border-emerald-300 rounded-md focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 text-neutral-300"
          placeholder="0"
        />
      </div>

      <!-- Places dans l'avion -->
      <div>
        <label class="block text-sm font-medium text-emerald-500">
          Total number of seats in the plane
        </label>
        <input
          type="number"
          v-model.number="planeSeats"
          class="w-full px-3 py-1 border border-emerald-300 rounded-md focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 text-neutral-300"
          placeholder="0"
        />
      </div>

      <!-- Résultats en ligne -->
      <div class="px-2 bg-neutral-700 rounded-md">
        <h3 class="font-semibold text-emerald-500 mb-2 pt-1 text-center">Breakdown</h3>
        <div class="grid grid-cols-3 gap-4">
          <div class="text-center">
            <p class="text-xs text-gray-400">Y Seats</p>
            <p class="text-lg font-semibold text-emerald-600">{{ ySeats.toFixed(0) }}</p>
          </div>
          <div class="text-center">
            <p class="text-xs text-gray-400">J Seats</p>
            <p class="text-lg font-semibold text-emerald-600">{{ jSeats.toFixed(0) }}</p>
          </div>
          <div class="text-center">
            <p class="text-xs text-gray-400">F Seats</p>
            <p class="text-lg font-semibold text-emerald-600">{{ fSeats.toFixed(0) }}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
