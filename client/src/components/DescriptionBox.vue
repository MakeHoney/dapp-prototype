<template>
    <div class="description">
        <button v-on:click="register">임의로등록</button>
        <button v-on:click="clickButton1">기본정보 열람</button>
    </div>
</template>

<script>
export default {
    name:'description-box',
    data() {
        return {
            show: 0
        }
    },
    methods: {
        /* this.$store.state.contractInstance() => computed으로 넣어보기 */
        register (event) {
            this.$store.state.contractInstance().methods.register("foo", 0, 0, 0).send({
                    gas: 1000000,
                    value: 0,
                    from: this.$store.state.web3.coinbase
                }, (err, result) => {
                    if(err) console.log("error occured", err);
                    else {
                        console.log(result);
                    }
                }
            );
        },
        clickButton1 (event) {
            this.show = 1
            console.log(this.$store.state.contractInstance());
            this.$store.state.contractInstance().methods.getBasicUserInfo().call().then(console.log);
        }
    },
    mounted () {
        console.log('dispatching getContractInstance')
        this.$store.dispatch('getContractInstance');
    }
}
</script>
