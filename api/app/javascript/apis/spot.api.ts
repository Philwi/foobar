import { AxiosResponse } from 'axios';
import { http } from '@/services/http.service';

export const spots = (query): Promise<AxiosResponse> => {
  return http.get('forecast', { params: { spot: query } });
};
