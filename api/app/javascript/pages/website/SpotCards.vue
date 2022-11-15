<template lang="pug">
div(v-show="spots.length > 0")
  .grid-container
    template(v-for="spot in spots")
      .contact-us
        h1 {{ spot.name }}
        p Distance: {{ Math.ceil(spot.distance) }} km
        p Details: &nbsp;
          a(:href="surflineUrl(spot.surfline_v2_id)" target="_blank") Website
</template>

<script>
import { useSpotStore } from '@/stores/spots.store';
const spotStore = useSpotStore();

export default {
  computed: {
    spots() {
      return spotStore.spots;
    },
  },
  methods: {
    surflineUrl(id) {
      return `https://www.surfline.com/surf-report/foo/${id}`;
    },
  },
};
</script>

<style scoped="" lang="sass">
$form-bg: #f8f4e5
$form-shadow: #ffa580
$form-primary-highlight: #95a4ff
$form-secondary-highlight: #ffc8ff
$font-size: 14pt
$font-face: 'Fjalla One'
$font-color: #2A293E

.grid-container
  display: grid
  grid-template-columns: auto auto auto

.contact-us
  margin: 2rem
  padding: 20px
  background: $form-bg
  padding: 50px 100px
  border: 2px solid rgba(0,0,0,1)
  box-shadow: 15px 15px 1px $form-shadow, 15px 15px 1px 2px rgba(0,0,0,1)

p
  font-size: $font-size
  line-height: $font-size * 2
  font-family: $font-face
  color: rgba(0,0,0,1)

a
  font-size: $font-size
  line-height: $font-size * 2
  font-family: $font-face
  color: rgba(0,0,0,1)
</style>
