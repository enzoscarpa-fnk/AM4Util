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
  <div class="bg-white rounded-lg shadow-md p-6">
    <div class="flex justify-between items-center mb-6">
      <h2 class="text-2xl font-bold text-gray-800">Optimiseur de Sièges</h2>
      <button
        @click="clearForm"
        class="px-4 py-2 bg-red-500 text-white rounded-md hover:bg-red-600 transition-colors text-sm font-medium"
      >
        Clear
      </button>
    </div>

    <div class="space-y-4">
      <!-- Demande passagers Y -->
      <div>
        <label class="block text-sm font-medium text-gray-700 mb-1">
          Demande - Classe Y (Economy)
        </label>
        <input
          type="number"
          v-model.number="demandY"
          class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500"
          placeholder="0"
        />
      </div>

      <!-- Demande passagers J -->
      <div>
        <label class="block text-sm font-medium text-gray-700 mb-1">
          Demande - Classe J (Business)
        </label>
        <input
          type="number"
          v-model.number="demandJ"
          class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500"
          placeholder="0"
        />
      </div>

      <!-- Demande passagers F -->
      <div>
        <label class="block text-sm font-medium text-gray-700 mb-1">
          Demande - Classe F (First)
        </label>
        <input
          type="number"
          v-model.number="demandF"
          class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500"
          placeholder="0"
        />
      </div>

      <!-- Places dans l'avion -->
      <div>
        <label class="block text-sm font-medium text-gray-700 mb-1">
          Nombre total de places dans l'avion
        </label>
        <input
          type="number"
          v-model.number="planeSeats"
          class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500"
          placeholder="0"
        />
      </div>

      <!-- Résultats -->
      <div class="mt-6 p-4 bg-gray-50 rounded-md">
        <h3 class="font-semibold text-gray-700 mb-3">Répartition des sièges:</h3>
        <div class="space-y-2">
          <p class="text-sm text-gray-600">
            Sièges Y: <span class="font-semibold text-green-600">{{ ySeats.toFixed(0) }}</span>
          </p>
          <p class="text-sm text-gray-600">
            Sièges J: <span class="font-semibold text-green-600">{{ jSeats.toFixed(0) }}</span>
          </p>
          <p class="text-sm text-gray-600">
            Sièges F: <span class="font-semibold text-green-600">{{ fSeats.toFixed(0) }}</span>
          </p>
        </div>
      </div>
    </div>
  </div>
</template>
