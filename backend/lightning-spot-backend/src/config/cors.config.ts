import { CorsOptions } from '@nestjs/common/interfaces/external/cors-options.interface';
import { ConfigService } from '@nestjs/config';

export const createCorsOptions = (
  configService: ConfigService,
): CorsOptions => {
  const isDev = configService.get<string>('NODE_ENV') === 'development';

  const baseUrl = `${configService.get<string>('CLIENT_HOST')}:${configService.get<string>('CLIENT_PORT')}`;
  const originList = new Set<string>();

  if (isDev) {
    originList.add(baseUrl);
  } else {
    if (baseUrl) originList.add(baseUrl);

    const originEnvList = configService.get<string>('CORS_ORIGIN_LIST');
    if (originEnvList) {
      originEnvList.split(',').map((origin) => originList.add(origin.trim()));
    }
  }

  return {
    origin: Array.from(originList),
    credentials: true,
  };
};
