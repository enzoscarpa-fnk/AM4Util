<script setup>
import { ref, provide } from 'vue'
import TicketCalculator from "@/components/TicketCalculator.vue";
import SeatOptimizer from "@/components/SeatOptimizer.vue";

const openTool = ref('ticket')

const toggleTool = (toolName) => {
  openTool.value = openTool.value === toolName ? null : toolName
}

provide('openTool', openTool)
provide('toggleTool', toggleTool)
</script>

<template>
  <div class="min-h-screen bg-stone-900 py-4 px-3">
    <div class="max-w-4xl">
      <!-- Header -->
      <div class="flex gap-3 mb-6">
        <!-- Logo -->
        <svg class="w-14 h-14 text-emerald-500 rotate-45" fill="currentColor" viewBox="0 0 24 24">
          <path d="M21 16v-2l-8-5V3.5c0-.83-.67-1.5-1.5-1.5S10 2.67 10 3.5V9l-8 5v2l8-2.5V19l-2 1.5V22l3.5-1 3.5 1v-1.5L13 19v-5.5l8 2.5z"/>
        </svg>

        <!-- App name -->
        <div>
          <h1 class="text-3xl font-bold text-emerald-500">AM4 Utilities</h1>
          <p class="text-sm text-gray-400">Airlines Manager 4 Tools</p>
        </div>
      </div>

      <!-- Tools -->
      <div class="space-y-3">
        <TicketCalculator
          :is-open="openTool === 'ticket'"
          @toggle="toggleTool('ticket')"
        />
        <SeatOptimizer
          :is-open="openTool === 'seat'"
          @toggle="toggleTool('seat')"
        />
      </div>

      <!-- Footer -->
      <div class="mt-6 text-sm text-rose-400 underline text-center">
        <a href="https://github.com/enzoscarpa-fnk/AM4Util/issues" target="_blank" rel="noopener noreferrer">
          Report a bug and help us enhance this tool
        </a>
      </div>
    </div>
  </div>
</template>

