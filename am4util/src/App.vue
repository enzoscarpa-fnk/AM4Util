<script setup>
import TicketCalculator from "@/components/TicketCalculator.vue";
import SeatOptimizer from "@/components/SeatOptimizer.vue";
</script>

<template>
  <div class="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 py-8 px-4">
    <div class="max-w-7xl mx-auto">
      <h1 class="text-4xl font-bold text-center text-gray-800 mb-8">AM4 Utility</h1>

      <div class="grid md:grid-cols-2 gap-6">
        <TicketCalculator />
        <SeatOptimizer />
      </div>
    </div>
  </div>
</template>

