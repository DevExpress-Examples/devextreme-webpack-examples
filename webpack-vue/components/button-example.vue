<template>
    <dx-button
    text="Say 'Hello world'"
    @click="showAlert" />
</template>

<script>
import { DxButton } from "devextreme-vue/button";
import { alert } from "devextreme/ui/dialog";

export default {
  components: {
    DxButton
  },
  methods: {
    showAlert() {
      alert("Hello world!", "", false);
    }
  }
};
</script>
