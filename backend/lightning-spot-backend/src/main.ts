import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ConfigService } from '@nestjs/config';
import { createCorsOptions } from './config/\bcors.config';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  /** enable cors */
  const configService = app.get(ConfigService);
  const corsOptions = createCorsOptions(configService);
  app.enableCors(corsOptions);

  /** set port */
  const port = configService.get<number>('PORT');

  await app.listen(port ?? 3000);
}
bootstrap();
