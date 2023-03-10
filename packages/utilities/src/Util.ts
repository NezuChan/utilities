import fs from "node:fs";
import { decode, encode } from "base65536";

export class Util {
    public static formatDate(dateFormat: Intl.DateTimeFormat, date: Date | number = new Date()): string {
        const data = dateFormat.formatToParts(date);
        return "<year>-<month>-<day>"
            .replace(/<year>/g, data.find(d => d.type === "year")!.value)
            .replace(/<month>/g, data.find(d => d.type === "month")!.value)
            .replace(/<day>/g, data.find(d => d.type === "day")!.value);
    }

    public static loadJSON<T>(path: string): T {
        return JSON.parse(fs.readFileSync(new URL(path, import.meta.url)) as unknown as string) as T;
    }

    public static decodeBase65536<T>(bufferOrString: Uint8Array | string): T {
        if (typeof bufferOrString === "string") bufferOrString = decode(bufferOrString);
        return JSON.parse(Buffer.from(bufferOrString.buffer, bufferOrString.byteOffset, bufferOrString.byteLength).toString("utf-8")) as T;
    }

    public static encodeBase65536(str: string): string {
        return encode(Buffer.from(str));
    }

    public static date(): string {
        return Util.formatDate(Intl.DateTimeFormat("en-US", {
            year: "numeric",
            month: "numeric",
            day: "numeric",
            hour12: false
        }));
    }
}
