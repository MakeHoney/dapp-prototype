<template>
    <div>
        <!-- <view-mode/> -->
        <description-box/>
        <metamask-state/>
    </div>
</template>

<script>
import ViewMode from './ViewMode.vue'
import DescriptionBox from './DescriptionBox.vue'
import MetamaskState from './MetamaskState.vue'

export default {
    name: 'proto-dapp',
    beforeCreate () {
        this.$store.dispatch('registerWeb3');
    },
    components: {
        ViewMode,
        DescriptionBox,
        MetamaskState
    }
}
</script>

<style>

</style>

