<template>
  <div id="app">
    <transition name="fade">
      <router-view />
    </transition>
  </div>
</template>

<style>
@import url("https://fonts.googleapis.com/css2?family=Lato:wght@100;300;400&display=swap");
#app {
  font-family: "Lato", "Segoe UI", "Tahoma", "Geneva", "Verdana", "sans-serif";
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: var(--primary-text);
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s;
}
.fade-enter,
.fade-leave-to {
  opacity: 0;
}
button:focus {
  outline: none !important;
  box-shadow: none !important;
}

a {
  text-decoration: none;
}

.section-header {
  font-size: 1rem;
  font-weight: 200;
}
:root {
  --primary-bg: #f7f7f3;
  --primary-text: #383837;
  --secondary-bg: #787875;
  --secondary-text: #b8b8b4;
  --func-bg: #333;
  --third-bg: #2f4f4f;
  --highlight: #f38034;
}
[data-theme="light"] {
  --primary-bg: #faebd7;
  --primary-text: #2f4f4f;
}
</style>
