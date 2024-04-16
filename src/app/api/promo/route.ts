import { db } from "@/lib/db";
import { NextRequest, NextResponse } from "next/server";

export async function GET(req: NextRequest, res: NextResponse) {
    try {

        const promo = await db.promo.findMany();
        return NextResponse.json({ success: true, promo });
    } catch (e) {
        return NextResponse.json({
            success: false,
            message: "Произошла неизвестная ошибка, попробуйте снова :(",
            e,
        });
    }
}