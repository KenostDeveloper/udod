import { db } from "@/lib/db";
import { NextRequest, NextResponse } from "next/server";

export async function GET(req: NextRequest, res: NextResponse) {
    try {

        const food:any = await db.food.findMany({
            include: {
                category: true
            }
        });

        for(let i = 0; i < food.length; i++){
            food[i]['active'] = false;
            food[i]['count'] = 0;
        }

        return NextResponse.json({ success: true, food });
    } catch (e) {
        return NextResponse.json({
            success: false,
            message: "Произошла неизвестная ошибка, попробуйте снова :(",
            e,
        });
    }
}