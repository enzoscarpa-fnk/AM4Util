<script setup>
import { ref, computed, watch } from 'vue'
import Fuse from 'fuse.js'
import aircraftsData from '@/data/aircrafts.json'

const demandY = ref('')
const demandJ = ref('')
const demandF = ref('')
const planeSeats = ref('')
const searchQuery = ref('')
const selectedAircraftId = ref(null)

const fields = {
  demandY,
  demandJ,
  demandF,
  planeSeats
}

// Fuse.js configuration for fuzzy search
const fuse = new Fuse(aircraftsData, {
  keys: ['model'],
  threshold: 0.3,
  includeScore: true
})

// Computed: Filtered aircrafts based on search query
const filteredAircrafts = computed(() => {
  if (!searchQuery.value) {
    return aircraftsData
  }
  const results = fuse.search(searchQuery.value)
  return results.map(result => result.item)
})

// Computed: Selected aircraft object
const selectedAircraft = computed(() => {
  if (!selectedAircraftId.value) return null
  return aircraftsData.find(a => a.id === selectedAircraftId.value)
})

// Method: Handle aircraft selection
const onAircraftSelect = () => {
  if (selectedAircraft.value) {
    planeSeats.value = selectedAircraft.value.seats.toString()
    searchQuery.value = '' // Clear search when selecting from dropdown
  }
}

// Watch: Auto-select first result when searching
watch(filteredAircrafts, (newFiltered) => {
  if (searchQuery.value && newFiltered.length === 1) {
    selectedAircraftId.value = newFiltered[0].id
    onAircraftSelect()
  }
})

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
  searchQuery.value = ''
  selectedAircraftId.value = null
}

const filterInteger = (field) => {
  field.value = field.value.replace(/\D/g, '')
}

// Helper: Format price
const formatPrice = (price) => {
  return new Intl.NumberFormat('en-US', {
    minimumFractionDigits: 0,
    maximumFractionDigits: 0
  }).format(price)
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

    <!-- Aircraft Selection Section -->
    <div class="space-y-2 mb-3 bg-neutral-700 p-3 rounded-lg">

      <!-- Fuzzy Search Input -->
      <div>
        <label class="block text-xs font-medium text-emerald-500 mb-1">
          Search Aircraft
        </label>
        <input
          v-model="searchQuery"
          type="text"
          placeholder="Type to search (e.g., A320, Boeing 777)..."
          class="w-full px-3 py-1 border border-emerald-300 rounded-md focus:outline-none focus:ring-2 focus:ring-emerald-500 text-neutral-300 text-sm"
        />
      </div>

      <!-- Aircraft Dropdown -->
      <div>
        <label class="block text-xs font-medium text-emerald-500 mb-1">
          Or select from list
        </label>
        <select
          v-model="selectedAircraftId"
          @change="onAircraftSelect"
          class="w-full px-3 py-1 border border-emerald-300 rounded-md focus:outline-none focus:ring-2 focus:ring-emerald-500 text-neutral-300 text-sm bg-stone-800"
        >
          <option :value="null">-- Select an aircraft --</option>
          <option
            v-for="aircraft in filteredAircrafts"
            :key="aircraft.id"
            :value="aircraft.id"
          >
            {{ aircraft.model }} ({{ aircraft.seats }} seats)
          </option>
        </select>
      </div>

      <!-- Aircraft Info Display -->
      <div v-if="selectedAircraft" class="bg-neutral-800 p-2 rounded-md border border-emerald-500/30">
        <div class="grid grid-cols-2 gap-2 text-xs">
          <div><span class="font-medium text-emerald-400">Model:</span> <span class="text-neutral-300">{{ selectedAircraft.model }}</span></div>
          <div><span class="font-medium text-emerald-400">Seats:</span> <span class="text-neutral-300">{{ selectedAircraft.seats }}</span></div>
          <div class="col-span-2"><span class="font-medium text-emerald-400">Base Price:</span> <span class="text-neutral-300">${{ formatPrice(selectedAircraft.base_price) }}</span></div>
        </div>
      </div>
    </div>

    <!-- Passengers demand -->
    <div class="space-y-3">
      <div v-for="(label, key) in {
        demandY: 'Demand - Y Class (Economy)',
        demandJ: 'Demand - J Class (Business)',
        demandF: 'Demand - F Class (First)',
        planeSeats: 'Total number of seats in the plane'
      }" :key="key">
        <label class="block text-sm font-medium text-emerald-500">
          {{ label }}
          <span v-if="key === 'planeSeats' && selectedAircraft" class="text-gray-400 text-xs">(auto-filled, can be overridden)</span>
        </label>
        <input
          type="text"
          v-model="fields[key].value"
          @input="filterInteger(fields[key])"
          maxlength="5"
          class="w-full px-3 py-1 border border-emerald-300 rounded-md focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 text-neutral-300"
          placeholder="0"
        />
      </div>

      <!-- Breakdown -->
      <div class="px-2 bg-neutral-700 rounded-md">
        <div class="grid grid-cols-3 gap-4 py-2">
          <div class="text-center">
            <p class="text-xs text-gray-400 pb-1">Y Seats</p>
            <p class="w-24 mx-auto text-lg font-semibold text-emerald-500 bg-neutral-600 rounded-md">{{ ySeats }}</p>
          </div>
          <div class="text-center">
            <p class="text-xs text-gray-400 pb-1">J Seats</p>
            <p class="w-24 mx-auto text-lg font-semibold text-emerald-500 bg-neutral-600 rounded-md">{{ jSeats }}</p>
          </div>
          <div class="text-center">
            <p class="text-xs text-gray-400 pb-1">F Seats</p>
            <p class="w-24 mx-auto text-lg font-semibold text-emerald-500 bg-neutral-600 rounded-md">{{ fSeats }}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
