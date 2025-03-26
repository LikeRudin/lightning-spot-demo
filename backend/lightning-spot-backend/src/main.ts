import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  await app.listen(process.env.PORT ?? 3000);

  const user = await prisma.user.findMany({
    take: 10,
  });
  console.log(`test array: ${JSON.stringify(user)}`);
}
bootstrap();
