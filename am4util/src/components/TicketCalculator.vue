<script setup>
import { ref, computed } from 'vue'

const baseYPrice = ref(0)
const baseJPrice = ref(0)
const baseFPrice = ref(0)

// Fonction pour arrondir à la 5e unité inférieure
const roundDownToNearest5 = (num) => {
  return Math.floor(num / 5) * 5
}

const calculatedYPrice = computed(() => roundDownToNearest5(baseYPrice.value * 1.1))
const calculatedJPrice = computed(() => roundDownToNearest5(baseJPrice.value * 1.08))
const calculatedFPrice = computed(() => roundDownToNearest5(baseFPrice.value * 1.06))

const clearForm = () => {
  baseYPrice.value = 0
  baseJPrice.value = 0
  baseFPrice.value = 0
}
</script>

<template>
  <div class="bg-white rounded-lg shadow-md p-6">
    <div class="flex justify-between items-center mb-6">
      <h2 class="text-2xl font-bold text-gray-800">Calculateur de Prix de Billets</h2>
      <button
        @click="clearForm"
        class="px-4 py-2 bg-red-500 text-white rounded-md hover:bg-red-600 transition-colors text-sm font-medium"
      >
        Clear
      </button>
    </div>

    <div class="space-y-4">
      <!-- Billet Y -->
      <div>
        <label class="block text-sm font-medium text-gray-700 mb-1">
          Prix de base - Classe Y (Economy)
        </label>
        <input
          type="number"
          v-model.number="baseYPrice"
          class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
          placeholder="0.00"
        />
        <p class="mt-2 text-sm text-gray-600">
          Prix calculé: <span class="font-semibold text-blue-600">{{ calculatedYPrice.toFixed(2) }} €</span>
        </p>
      </div>

      <!-- Billet J -->
      <div>
        <label class="block text-sm font-medium text-gray-700 mb-1">
          Prix de base - Classe J (Business)
        </label>
        <input
          type="number"
          v-model.number="baseJPrice"
          class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
          placeholder="0.00"
        />
        <p class="mt-2 text-sm text-gray-600">
          Prix calculé: <span class="font-semibold text-blue-600">{{ calculatedJPrice.toFixed(2) }} €</span>
        </p>
      </div>

      <!-- Billet F -->
      <div>
        <label class="block text-sm font-medium text-gray-700 mb-1">
          Prix de base - Classe F (First)
        </label>
        <input
          type="number"
          v-model.number="baseFPrice"
          class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
          placeholder="0.00"
        />
        <p class="mt-2 text-sm text-gray-600">
          Prix calculé: <span class="font-semibold text-blue-600">{{ calculatedFPrice.toFixed(2) }} €</span>
        </p>
      </div>
    </div>
  </div>
</template>
