<template>
  <div>
    <nav
      id="header"
      class="w-full z-30 top-10 py-1 bg-white shadow-lg border-b border-blue-400"
    >
      <div class="w-full flex items-center justify-between mt-0 px-6 py-2">
        <label for="menu-toggle" class="cursor-pointer md:hidden block">
          <svg
            class="fill-current text-blue-600"
            xmlns="http://www.w3.org/2000/svg"
            width="20"
            height="20"
            viewBox="0 0 20 20"
          >
            <title>menu</title>
            <path d="M0 3h20v2H0V3zm0 6h20v2H0V9zm0 6h20v2H0v-2z"></path>
          </svg>
        </label>
        <input class="hidden" type="checkbox" id="menu-toggle" />

        <div
          class="hidden md:flex md:items-center md:w-auto w-full order-3 md:order-1"
          id="menu"
        >
          <nav>
            <ul
              class="md:flex items-center justify-between text-base text-blue-600 pt-4 md:pt-0"
            >
              <li>
                <a
                  class="inline-block no-underline hover:text-black font-medium text-lg py-2 px-4 lg:-ml-2"
                  href="#"
                >
                  MarketPlace Test
                </a>
              </li>
            </ul>
          </nav>
        </div>

        <div
          class="order-2 md:order-3 flex flex-wrap items-center justify-end mr-0 md:mr-4"
          id="nav-content"
        >
          <div class="auth flex items-center w-full md:w-full">
            <button
              v-if="!account"
              class="bg-blue-600 text-gray-200 p-2 rounded hover:bg-blue-500 hover:text-gray-100"
              @click="connectWallet"
            >
              Connect Wallet
            </button>
            <span v-else>{{ account }}</span>
          </div>
        </div>
      </div>
    </nav>

    <router-view />
  </div>
</template>

<script>
import Web3 from 'web3'
export default {
  data: () => ({}),

  computed: {
    account() {
      return this.$store.getters.getAccount
    },
  },

  methods: {
    async initWeb3() {
      if (window.ethereum) {
        window.web3 = new Web3(window.ethereum)
        await window.ethereum.enable()
      } else if (window.web3) {
        window.web3 = new Web3(window.web3.currentProvider)
      } else {
        window.alert(
          'Non-Ethereum browser detected. You should consider trying MetaMask!',
        )
      }
    },

    connectWallet() {
      this.initWeb3()
      this.getAccount()
    },

    async getAccount() {
      const account_list = await window.web3.eth.getAccounts()
      this.$store.commit('setAccount', account_list[0])
    },
  },
}
</script>
