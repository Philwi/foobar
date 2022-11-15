const Index = () => import('@/pages/website/IndexPage.vue');

const routes = [
  {
    path: '/',
    name: 'index',
    components: {
      default: Index,
    },
  },
];

export default routes;
