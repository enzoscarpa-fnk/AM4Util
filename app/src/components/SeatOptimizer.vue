<script setup>
import { ref, computed, watch, onMounted, onUnmounted, defineProps, defineEmits } from 'vue'
import Fuse from 'fuse.js'
import aircraftsData from '@/data/aircrafts.json'

const props = defineProps({
  isOpen: {
    type: Boolean,
    default: true
  }
})

const emit = defineEmits(['toggle'])

const demandY = ref('')
const demandJ = ref('')
const demandF = ref('')
const planeSeats = ref('')
const searchQuery = ref('')
const selectedAircraftId = ref(null)
const isDropdownOpen = ref(false)
const highlightedIndex = ref(-1)
const searchInputRef = ref(null)
const dropdownRef = ref(null)

const fields = {
  demandY,
  demandJ,
  demandF,
  planeSeats
}

// Fuse.js configuration
const fuse = new Fuse(aircraftsData, {
  keys: ['model'],
  threshold: 0.25,
  includeScore: true,
  minMatchCharLength: 2,
  ignoreLocation: true,
  shouldSort: true,
})

const filteredAircrafts = computed(() => {
  if (!searchQuery.value) return aircraftsData
  const results = fuse.search(searchQuery.value)
  return results.map(result => result.item)
})

const selectedAircraft = computed(() => {
  if (!selectedAircraftId.value) return null
  return aircraftsData.find(a => a.id === selectedAircraftId.value)
})

const selectAircraft = (aircraft) => {
  selectedAircraftId.value = aircraft.id
  planeSeats.value = aircraft.seats.toString()
  searchQuery.value = aircraft.model
  isDropdownOpen.value = false
  highlightedIndex.value = -1
}

watch(searchQuery, (newValue, oldValue) => {
  if (!newValue) {
    isDropdownOpen.value = false
    highlightedIndex.value = -1
    return
  }
  const isSelection = aircraftsData.some(a => a.model === newValue)
  if (isSelection && oldValue !== newValue) return
  isDropdownOpen.value = true
  highlightedIndex.value = 0
})

watch(filteredAircrafts, () => {
  highlightedIndex.value = 0
})

const handleKeydown = (event) => {
  if (!isDropdownOpen.value) {
    if (event.key === 'Enter' && searchQuery.value) {
      isDropdownOpen.value = true
      return
    }
    return
  }

  switch (event.key) {
    case 'ArrowDown':
      event.preventDefault()
      highlightedIndex.value = Math.min(highlightedIndex.value + 1, filteredAircrafts.value.length - 1)
      scrollToHighlighted()
      break
    case 'ArrowUp':
      event.preventDefault()
      highlightedIndex.value = Math.max(highlightedIndex.value - 1, 0)
      scrollToHighlighted()
      break
    case 'Enter':
      event.preventDefault()
      if (highlightedIndex.value >= 0 && filteredAircrafts.value[highlightedIndex.value]) {
        selectAircraft(filteredAircrafts.value[highlightedIndex.value])
      }
      break
    case 'Escape':
      isDropdownOpen.value = false
      highlightedIndex.value = -1
      break
  }
}

const scrollToHighlighted = () => {
  const dropdown = dropdownRef.value
  if (!dropdown) return
  const highlightedElement = dropdown.children[highlightedIndex.value]
  if (highlightedElement) {
    highlightedElement.scrollIntoView({ block: 'nearest', behavior: 'smooth' })
  }
}

const handleClickOutside = (event) => {
  if (searchInputRef.value && !searchInputRef.value.contains(event.target) &&
    dropdownRef.value && !dropdownRef.value.contains(event.target)) {
    isDropdownOpen.value = false
  }
}

const toggleDropdown = () => {
  isDropdownOpen.value = !isDropdownOpen.value
  if (isDropdownOpen.value) highlightedIndex.value = 0
}

const clearAircraftSelection = () => {
  selectedAircraftId.value = null
  searchQuery.value = ''
  isDropdownOpen.value = false
}

onMounted(() => {
  document.addEventListener('click', handleClickOutside)
})

onUnmounted(() => {
  document.removeEventListener('click', handleClickOutside)
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

const hasResults = computed(() => {
  return (demandY.value || demandJ.value || demandF.value) && planeSeats.value
})

const clearForm = () => {
  demandY.value = ''
  demandJ.value = ''
  demandF.value = ''
  planeSeats.value = ''
  clearAircraftSelection()
}

const filterInteger = (field) => {
  field.value = field.value.replace(/\D/g, '')
}

const formatPrice = (price) => {
  return new Intl.NumberFormat('en-US', {
    minimumFractionDigits: 0,
    maximumFractionDigits: 0
  }).format(price)
}
</script>

<template>
  <div class="bg-stone-800 rounded-xl shadow-md overflow-hidden">
    <!-- Header -->
    <div
      @click="emit('toggle')"
      class="flex justify-between items-center p-3 cursor-pointer hover:bg-stone-700 transition-colors"
    >
      <h2 class="text-xl font-bold text-emerald-500">Seat Optimizer</h2>

      <div class="flex items-center gap-2 flex-shrink-0">
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

    <!-- Inputs content (hidden when collapsed) -->
    <Transition
      enter-active-class="transition-all duration-200 ease-out"
      enter-from-class="max-h-0 opacity-0"
      enter-to-class="max-h-[800px] opacity-100"
      leave-active-class="transition-all duration-200 ease-in"
      leave-from-class="max-h-[800px] opacity-100"
      leave-to-class="max-h-0 opacity-0"
    >
      <div v-if="isOpen" class="px-3 pb-3 space-y-3">
        <!-- Aircraft Selection Section -->
        <div class="space-y-1.5 bg-neutral-700 p-2 pb-1 rounded-lg">
          <h3 class="text-sm font-semibold text-emerald-400">Search or Select Aircraft</h3>

          <!-- Combobox Search Input with Dropdown -->
          <div class="relative">
            <div class="relative">
              <input
                ref="searchInputRef"
                v-model="searchQuery"
                @keydown="handleKeydown"
                @focus="searchQuery && (isDropdownOpen = true)"
                type="text"
                placeholder="Type to search (e.g. A330, MD-11...)"
                class="w-full px-3 py-1.5 pr-20 border border-emerald-300 rounded-md focus:outline-none focus:ring-2 focus:ring-emerald-500 text-neutral-300 text-sm bg-stone-800"
              />

              <!-- Badge with results count -->
              <div v-if="searchQuery" class="absolute right-2 top-1/2 -translate-y-1/2 flex items-center gap-1">
                <span class="text-xs bg-emerald-600 text-white px-2 py-0.5 rounded-full">
                  {{ filteredAircrafts.length }}
                </span>
                <button
                  v-if="selectedAircraft"
                  @click="clearAircraftSelection"
                  class="text-gray-400 hover:text-white"
                  title="Clear selection"
                >
                  ×
                </button>
                <button
                  @click="toggleDropdown"
                  class="text-emerald-400 hover:text-emerald-300"
                  title="Toggle dropdown"
                >
                  <svg class="w-4 h-4 transition-transform" :class="{ 'rotate-180': isDropdownOpen }" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                  </svg>
                </button>
              </div>
            </div>

            <!-- Dropdown Results -->
            <Transition
              enter-active-class="transition ease-out duration-100"
              enter-from-class="transform opacity-0 scale-95"
              enter-to-class="transform opacity-100 scale-100"
              leave-active-class="transition ease-in duration-75"
              leave-from-class="transform opacity-100 scale-100"
              leave-to-class="transform opacity-0 scale-95"
            >
              <div
                v-if="isDropdownOpen && filteredAircrafts.length > 0"
                ref="dropdownRef"
                class="absolute z-10 w-full mt-1 bg-stone-800 border border-emerald-500/30 rounded-md shadow-lg max-h-60 overflow-auto"
              >
                <div
                  v-for="(aircraft, index) in filteredAircrafts"
                  :key="aircraft.id"
                  @click="selectAircraft(aircraft)"
                  @mouseenter="highlightedIndex = index"
                  class="px-3 py-2 cursor-pointer transition-colors text-sm"
                  :class="{
                    'bg-emerald-600 text-white': index === highlightedIndex,
                    'bg-emerald-500/20': selectedAircraftId === aircraft.id && index !== highlightedIndex,
                    'text-neutral-300 hover:bg-stone-700': index !== highlightedIndex && selectedAircraftId !== aircraft.id
                  }"
                >
                  <div class="flex justify-between items-center">
                    <span class="font-medium">{{ aircraft.model }}</span>
                    <span class="text-xs opacity-75">{{ aircraft.seats }} seats</span>
                  </div>
                </div>
              </div>
            </Transition>

            <!-- No results message -->
            <div
              v-if="isDropdownOpen && searchQuery && filteredAircrafts.length === 0"
              class="absolute z-10 w-full mt-1 bg-stone-800 border border-rose-500/30 rounded-md shadow-lg p-3"
            >
              <p class="text-sm text-rose-400">No aircraft found for "{{ searchQuery }}"</p>
            </div>
          </div>

          <!-- Aircraft Info Display -->
          <div v-if="selectedAircraft" class="bg-stone-800 p-2 rounded-md border border-emerald-500/30">
            <div class="flex flex-wrap justify-center gap-x-8 gap-y-1 text-xs">
              <div class="flex items-center gap-1.5 min-w-0 max-w-full lg:max-w-[50%]">
                <svg class="w-4 h-4 text-emerald-400 flex-shrink-0" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M21 16v-2l-8-5V3.5c0-.83-.67-1.5-1.5-1.5S10 2.67 10 3.5V9l-8 5v2l8-2.5V19l-2 1.5V22l3.5-1 3.5 1v-1.5L13 19v-5.5l8 2.5z"/>
                </svg>
                <span class="text-neutral-300 truncate font-medium">{{ selectedAircraft.model }}</span>
              </div>

              <!-- Grouped Seats & Price -->
              <div class="flex items-center gap-8 flex-shrink-0">
                <div class="flex items-center gap-1.5">
                  <svg class="w-4 h-4 text-emerald-400 flex-shrink-0" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M4 18v3h3v-3h10v3h3v-6H4zm15-8h3v3h-3zM2 10h3v3H2zm15 3H7V5c0-1.1.9-2 2-2h6c1.1 0 2 .9 2 2v8z"/>
                  </svg>
                  <span class="text-neutral-300">{{ selectedAircraft.seats }}</span>
                </div>

                <div class="flex items-center gap-1.5">
                  <svg class="w-3.5 h-3.5 text-emerald-400 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M17.707 9.293a1 1 0 010 1.414l-7 7a1 1 0 01-1.414 0l-7-7A.997.997 0 012 10V5a3 3 0 013-3h5c.256 0 .512.098.707.293l7 7zM5 6a1 1 0 100-2 1 1 0 000 2z" clip-rule="evenodd"/>
                  </svg>
                  <span class="text-neutral-300">${{ formatPrice(selectedAircraft.base_price) }}</span>
                </div>
              </div>
            </div>
          </div>

          <!-- Keyboard hints -->
          <p class="hidden lg:block text-xs text-gray-500 mt-1">
            <kbd class="px-1 bg-stone-600 rounded">↑↓</kbd> navigate ·
            <kbd class="px-1 bg-stone-600 rounded">Enter</kbd> select ·
            <kbd class="px-1 bg-stone-600 rounded">Esc</kbd> close
          </p>
        </div>

        <!-- Passengers demand inputs -->
        <div v-for="(label, key) in {
          demandY: 'Demand - Y Class (Economy)',
          demandJ: 'Demand - J Class (Business)',
          demandF: 'Demand - F Class (First)',
          planeSeats: 'Total number of seats in the plane'
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

    <!-- Results (showing if hasResults) -->
    <div v-if="hasResults" class="px-3 pb-3">
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
