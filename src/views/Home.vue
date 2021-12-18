<template>
  <div class="home">
    <MainMarket msg="Welcome to Your Vue.js App" />
  </div>
</template>

<script>
// @ is an alias to /src
import MainMarket from "@/components/MainMarket.vue";

export default {
  name: "Home",
  components: {
    MainMarket,
  },
};
</script>
