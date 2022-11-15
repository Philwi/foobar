import { http, setHTTPHeader } from './http.service';
import { spots } from '@/apis/spot.api';

class SpotService {
  async query(spotQuery) {
    return spots(spotQuery).then((response) => {
      return response.data;
    });
  }
}

const instance = new SpotService();

export default instance;
