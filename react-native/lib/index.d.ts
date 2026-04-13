export interface OfferwallConfig {
    partnerId: string;
    userId: string;
    subId?: string;
    deviceId?: string;
    idfa?: string;
    gdfa?: string;
    info?: string;
    hideHeader?: boolean;
    hideFooter?: boolean;
}
export declare const BesitosOfferwall: {
    show(config: OfferwallConfig): void;
};
