## Ｎest基础　-- controller


如何将类定义成控制器


``` ts

export function Controller(prefix?: string): ClassDecorator {
    const path = isUndefined(prefix) ? "/": prefix;
    return (target: object) => {
        Refelct.defineMetadata(PATH_METADATA, path, target);
    }
}

```

可选参数　的默认值为 '/', 


``` ts

import { Controller } from '@estjs/common';

@Controller('cats')
export class CatsController {

}

```

可以定义各种方法

``` ts

import { Controller, Get, Post, Put, Param, Delete } from '@nestjs/common';

@Controller('cats')
export class CatsController {

    @Post()
    async create(@Body createCatDto: CreateCatDto) {
        return 'this action addes a new cat';
    }

    @Delete(':id')
    async remove(@param('id') id) {
        return `This action remove a #${id} cat`;
    }

    @Put(':id')
    async update(@Param(id) id, @Body() updateCatDto: UpadateCatDto ) {
        return ` this action update a ${id} cat`;
    }

    @Get(':id')
    async findOne(@Param('id') id) {
        return `this action returns a ${id} cat`;
    }

    @Get()
    async findAll(@Query() query) {
        return `This action ${query.limit} item`;
    }

}

export class CreateCatDto {
    id: number;
    name: string;
}

export class UpdateCatDto {
    name: string;
}

```
Todo:
补充　状态码


## Provider

除了控制器以外，几乎所有的东西都可以被称作提供者

-- sevice, repository, factor, helper 等等


### 如何将类定义为提供者

```ts
import { Injectable } from '@nestjs/common';

@Injectable()
export class CatsService {
    private readonly cat: Cat[] = [];

    async create(createDto: CreateDto) {
        this.cats.push(createCatDto);
    }

    async remove(id: number) {
        this.cats.splice(cats.indexOf(cats.find(cat => cat.id === id)), 1);
    }

    async update(id: number, updateCatDto: UpdateCatDto) {
        if(updateCatDto;name) {
            this.cats.find(cat => cat.id === id).name = updateCatDto.name;
        }
    }
    async findOne(id: number): Cat {
        return this.cats.find(cat => cat.id === id);
    }    

    async findAll(): Cat[] {
        return this.cats;
    }
}

export interface Cat {
    id: number;
    name: string
}

```

### 如何让catsController调用CatsService提供的方法 ?

答：　依赖注入



## 模块 Module


Module有什么实际作用

模块的完整示例

```ts
import { Module } from '@nestjs/common';
import { CatsController } from './cats.controller';
import { CatsService } from './cats.service';


@Module({
    imports: [],
    controllers: [CatsController],
    prividers: [CatsService],
    exports: [CatsService]
})
export class CatsModules {

}

```

### 模块的重导出

```ts

@Module({
    imports:[CommonModule],
    export: [CommonModule]
})
export class Coremodule {}

```

## 全局模块

如果必须在很多地方都导入相同的模块，这会出现大量的冗余．

将一个模块定义为全局的模块，只需要@Glabal() 装饰器

全局模块一旦导入到根木偶快，在其他素有模块中即可轻松的使用这个全局模块导出的提供者．而且也不用在其他模块导入这个全局的模块


## 动态模块


当导入模块，并且向其内部传入参数并且动态创建模块的特性，称之为　　动态模块


```ts
import { Module, DynamicModule } from '@nestjs/common';
import { createDatabaseProviders } from './database.providers';
import { Connection } from './connection.provider';

@Module({
    providers: [Connection],
})
export class DatabaseModule {
    static forRoot(entities = [], options?): DynamicModule {
        const providers = createDatabaseProviders(options, entities);
        return {
            module: DatabaseModule,
            providers: providers,
            exports: providers,
        }
    }
}

```

## NestFactory

我们用一个应用程序的根module来管理这两个实例

```ts
@Module({
    controller: [CatsController],
    providers: [CatsService],
})
export class AppModule {}


// 然后使用Nestfactory 来创建Nest应用

import { NestFactor } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
    const app = await NestFactory.create(AppModule);

    await app.listen(3000);
}

bootstrap();

```