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
        <div class="text-sm text-rose-400 underline text-center">
          <a href="https://github.com/enzoscarpa-fnk/AM4Util/issues" target="_blank" rel="noopener noreferrer">Report a bug or help us enhance this tool</a>
        </div>
      </div>
    </div>
  </div>
</template>

