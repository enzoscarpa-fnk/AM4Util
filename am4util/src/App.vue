<script setup>
import TicketCalculator from "@/components/TicketCalculator.vue";
import SeatOptimizer from "@/components/SeatOptimizer.vue";
</script>

<template>
  <div class="min-h-screen bg-stone-900 py-3 px-3">
    <div class="max-w-7xl mx-auto">
      <div class="grid md:grid-cols-2 gap-3">
        <TicketCalculator />
        <SeatOptimizer />
      </div>
    </div>
  </div>
</template>

