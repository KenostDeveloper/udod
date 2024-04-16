import { NextRequest, NextResponse } from "next/server";
import { db } from "@/lib/db";
var fs = require('fs');

export async function POST(req: NextRequest, res: NextResponse) {
    try{
        const data = await req.json();
        
        const food = data.food;
        const user = data.user;

        let cost = 0;
        let procent = 0;

        const promo = await db.promo.findMany();

        for(let i = 0; i < food.length; i++){
            if(food[i].active){
                cost += food[i].price * food[i].count;
            }
        }
    
        for(let i = 0; i < promo.length; i++){
            if(cost > promo[i].main_total_price && procent < promo[i].proccent){
                procent = promo[i].proccent
            }
        }

        const newUser = await db.currentClient.create({
            data: {
                date: new Date(Date.now()),
                name: user.name,
                address: user.address,
                tel: (user.tel).replaceAll(' ', ''),
                total_price: Number((cost - (cost / 100 * procent)).toFixed(2))
            }
        })

        for(let i = 0; i < food.length; i++){
            if(food[i].active){
                const newOrder = await db.orders.create({
                    data: {
                        count: food[i].count,
                        idFood: food[i].id,
                        idCurrentClient: newUser.id
                    }
                })
            }
        }

        const order:any = await db.currentClient.findUnique({
            where: {
                id: newUser.id
            },
            include: {
                orders: {
                    include: {
                        food: true
                    }
                }
            }
        })

        let text = `Заказ #${order.id}\n\nТовары в заказе:\n`

        for(let i = 0; i < order.orders.length; i++){
            text += `${order.orders[i].food.name}\t${order.orders[i].count}\t${order.orders[i].food.price}\n`
        }


        text += `\nСумма заказа: ${cost}\n`
        text += `Скидка ${procent}%: ${(cost / 100 * procent).toFixed(2)}₽\n`
        text += `Итого: ${Number((cost - (cost / 100 * procent)).toFixed(2))}₽\n`

        fs.writeFile(`${process.cwd()}/public/order_${order.id}.txt`, text, (err: any) => {
            if (err) throw err;
        })


        return NextResponse.json({success: true, message: "Заказ оформлен!", order});

    }catch(e){
        return NextResponse.json({success: false, message: "Произошла неизвестная ошибка, попробуйте снова :(", e});
    }
    
}