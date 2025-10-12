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
  <div class="bg-stone-800 rounded-xl shadow-md p-3">
    <div class="flex justify-between items-center">
      <h2 class="text-xl font-bold text-emerald-500 mb-2">Ticket price calculator</h2>

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
      <!-- Billet Y -->
      <div>
        <label class="block text-sm font-medium text-emerald-500">
          Base Price - Y Class (Economy)
        </label>
        <input
          type="number"
          v-model.number="baseYPrice"
          class="w-full px-3 py-1 border border-emerald-300 rounded-md focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 text-neutral-300"
          placeholder="0.00"
        />
      </div>

      <!-- Billet J -->
      <div>
        <label class="block text-sm font-medium text-emerald-500">
          Base Price - J Class (Business)
        </label>
        <input
          type="number"
          v-model.number="baseJPrice"
          class="w-full px-3 py-1 border border-emerald-300 rounded-md focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 text-neutral-300"
          placeholder="0.00"
        />
      </div>

      <!-- Billet F -->
      <div>
        <label class="block text-sm font-medium text-emerald-500">
          Base Price - F Class (First)
        </label>
        <input
          type="number"
          v-model.number="baseFPrice"
          class="w-full px-3 py-1 border border-emerald-300 rounded-md focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 text-neutral-300"
          placeholder="0.00"
        />
      </div>

      <!-- Prix calculés en ligne -->
      <div class="px-2 bg-neutral-700 rounded-md">
        <h3 class="font-semibold text-emerald-500 mb-2 pt-1 text-center">Calculated prices</h3>
        <div class="grid grid-cols-3 gap-4">
          <div class="text-center">
            <p class="text-xs text-gray-400">Y Class</p>
            <p class="text-lg font-semibold text-emerald-600">{{ calculatedYPrice.toFixed(0) }}</p>
          </div>
          <div class="text-center">
            <p class="text-xs text-gray-400">J Class</p>
            <p class="text-lg font-semibold text-emerald-600">{{ calculatedJPrice.toFixed(0) }}</p>
          </div>
          <div class="text-center">
            <p class="text-xs text-gray-400">F Class</p>
            <p class="text-lg font-semibold text-emerald-600">{{ calculatedFPrice.toFixed(0) }}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
