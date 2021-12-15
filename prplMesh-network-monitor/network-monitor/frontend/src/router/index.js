import Vue from "vue";
import VueRouter from "vue-router";

Vue.use(VueRouter);

const title = "Network Monitor - NEMS";

const routes = [
  {
    path: "/",
    name: "home",
    component: () => import("@/views/index"),
    meta: {
      redirectToProfile: true
    }
  },
  // {
  //   path: "*",
  //   component: () => import("@/views/fail/index"),
  //   hidden: true,
  //   meta: {
  //     title: "找不到此頁面"
  //   }
  // }
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes
});

router.beforeEach((to, from, next) => {
  window.document.title = `${title}`;
  next();
});

export default router;
