<template>
  <div class="bg-white">
    <div
      class="max-w-2xl mx-auto py-16 px-4 sm:py-24 sm:px-6 lg:max-w-7xl lg:px-8"
    >
      <div
        class="grid grid-cols-1 gap-y-10 sm:grid-cols-2 gap-x-6 lg:grid-cols-3 xl:grid-cols-4 xl:gap-x-8"
      >
        <div
          class="relative max-w-sm min-w-[340px] bg-white shadow-md rounded-3xl p-2 mx-1 my-3 cursor-pointer"
          v-for="(menu, i) in menu_list"
          :key="i"
        >
          <div class="overflow-x-hidden rounded-2xl relative">
            <img
              class="h-40 rounded-2xl w-full object-cover"
              :src="menu.image_hash"
            />
            <p
              class="absolute right-2 top-2 bg-white rounded-full p-2 cursor-pointer group"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="h-6 w-6 group-hover:opacity-50 opacity-70"
                fill="none"
                viewBox="0 0 24 24"
                stroke="black"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="1.5"
                  d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z"
                />
              </svg>
            </p>
          </div>
          <div class="mt-4 pl-2 mb-2 flex justify-between">
            <div>
              <p class="text-lg font-semibold text-gray-900 mb-0">
                {{ menu.description }}
              </p>
              <p class="text-md text-gray-800 mt-0">{{ menu.price }} ETH</p>
            </div>
            <div class="flex flex-col-reverse mb-1 mr-4 group cursor-pointer">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="h-6 w-6 group-hover:opacity-70"
                fill="none"
                viewBox="0 0 24 24"
                stroke="gray"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"
                />
              </svg>
            </div>
          </div>
        </div>

        <!-- More products... -->
      </div>
    </div>
  </div>
</template>

<script>
import ReattaMenu from '../abis/ReattaEatsContract.json'

export default {
  name: 'MainMarket',
  props: {
    msg: String,
  },

  data: () => ({
    menuSize: 0,
    reatta_menu: null,
    menu_list: [],
  }),

  computed: {
    account() {
      return this.$store.getters.getAccount
    },
  },
  watch: {
    account(v) {
      console.log(v);
      this.loadData();
    }
  },

  methods: {
    async loadData() {
      //get accounts

      //get network data
      const netID = await window.web3.eth.net.getId()
      const netData = ReattaMenu.networks[netID]

      if (netData) {
        const reContract = new window.web3.eth.Contract(
          ReattaMenu.abi,
          netData.address,
        )
        this.reatta_menu = reContract

        const menuCount = await reContract.methods.menuCount().call()
        this.menuSize = menuCount

        for (var i = 1; i <= menuCount; i++) {
          const menu = await reContract.methods.menus(i).call()
          this.menu_list.push(menu)
        }
      }
    },
  },

  mounted() {
    //this.initWeb3();
  },
}
</script>
