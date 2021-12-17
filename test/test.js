const ReattaEatsContract = artifacts.require('./ReattaEatsContract.sol')

require('chai').use(require('chai-as-promised')).should()

contract('ReattaEatsContract', ([deployer, author]) => {
  let re_contract

  before(async () => {
    re_contract = await ReattaEatsContract.deployed()
  })

  describe('deployment', async () => {
    it('deploys successfully', async () => {
      const address = await re_contract.address
      assert.notEqual(address, 0x0)
      assert.notEqual(address, '')
      assert.notEqual(address, null)
      assert.notEqual(address, undefined)
    })

  })
})
