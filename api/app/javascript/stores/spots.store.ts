import { defineStore } from 'pinia';
import { AxiosResponse } from 'axios';
import SpotService from '@/services/spot.service';

export const useSpotStore = defineStore('spot.store', {
  state: () => {
    return {
      _spots: [],
      _loadingState: false,
      _response: { message: '', type: 'info' },
    };
  },
  getters: {
    spots(state) {
      return state._spots;
    },
    loadingState(state) {
      return state._loadingState;
    },
    response(state) {
      return state._response;
    },
  },
  actions: {
    querySpots(query) {
      this._loadingState = true;

      return SpotService.query(query).then(
        (response: AxiosResponse) => {
          this._spots = response;
          this._response = { message: `${response.length} Spots found!`, type: 'success' };

          this._loadingState = false;
          return Promise.resolve(response);
        },
        (error) => {
          console.log(`fail ${error}`);
          this._loadingState = false;
          this._response = { message: error.errors.messages.join('\n'), type: 'error' };

          return Promise.reject(error);
        },
      );
    },
  },
});
