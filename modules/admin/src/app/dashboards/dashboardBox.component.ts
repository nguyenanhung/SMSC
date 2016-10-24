import {Component, Input, ViewEncapsulation, Output, EventEmitter, HostListener, Inject} from "@angular/core";
import {SidebarService} from "../sidebar/sidebarService";
import {DashboardBoxConfig} from "./dashboardBoxConfig";
import {BoxResize} from "./models/dashboardBoxEnum";
import {BrowserDomAdapter} from "@angular/platform-browser/src/browser/browser_adapter";
import {DashboardResizeConfig} from "./dashboardResizeConfig";
import { DOCUMENT } from '@angular/platform-browser';

@Component({
    selector: 'dashboard-box',
    template: require('./dashboardBox.html'),
    styleUrls: [
        require('./dashboardBox.scss')
    ],
    encapsulation: ViewEncapsulation.None,
    providers: [
        {provide: Window, useValue: window}
    ]
})
export class DashboardBoxComponent {
    @Input('config')
    public config: DashboardBoxConfig = <DashboardBoxConfig>{};

    @Output('resizeBox')
    public resizeBox: EventEmitter<Object> = new EventEmitter<Object>();

    @Output('removeBox')
    public removeBox: EventEmitter<number> = new EventEmitter<number>();

    @Output('editBox')
    public editBox: EventEmitter<number> = new EventEmitter<number>();

    public crudOpen: boolean = false;
    public viewWidthOpen: boolean = false;
    public fullscreenMode: boolean = false;
    public statusBoxWidth: number = 25;
    public statusBoxHeight: number = 25;
    public boxResize: BoxResize = BoxResize;
    public doughnutData: Array<Object> = [];
    public chart: any;
    public kindClass: string;

    constructor(private sidebarService: SidebarService,
                @Inject(DOCUMENT) private document: any) {
    }

    ngOnInit() {
        if (this.config.width != undefined) {
            this.statusBoxWidth = this.config.width;
        }

        if (this.config.height != undefined) {
            this.statusBoxHeight = this.config.height;
        }

        this.kindClass = this.getBoxKindClass(this.config.kind);
    }

    @HostListener('document:keydown', ['$event'])
    handleKeyboardEvent(event: KeyboardEvent) {
        event.stopImmediatePropagation();

        if (event.key == 'Escape' && this.sidebarService.fullScreenMode == true) {
            this.toggleFullscreen(true);

            let dom: BrowserDomAdapter = new BrowserDomAdapter();
            dom.removeClass(dom.query('.box .fullscreen'), 'fullscreen');
        }
    }

    /**
     * Toggle fullscreen for dashboard box.
     */
    toggleFullscreen(esc?: boolean) {
        this.sidebarService.toggleSidenav().then(() => {
            let dom: BrowserDomAdapter = new BrowserDomAdapter();

            if (this.sidebarService.fullScreenMode) {
                dom.query('.md-sidenav-content').scrollTop = this.sidebarService.prevTopScroll;
                dom.query('.md-sidenav-content').scrollLeft = this.sidebarService.prevLeftScroll;

                dom.removeStyle(dom.query('.md-sidenav-content'), 'overflow');
                dom.removeClass(dom.query('.header'), 'fullscreen-header');

                if (esc == undefined) {
                    dom.removeClass(dom.query('.box[data-boxrid="'+ this.config.customData['rid'] +'"] .content'), 'fullscreen');
                }

                this.sidebarService.fullScreenMode = false;
            }else {
                this.sidebarService.prevTopScroll = dom.query('.md-sidenav-content').scrollTop;
                this.sidebarService.prevLeftScroll = dom.query('.md-sidenav-content').scrollLeft;
                dom.query('.md-sidenav-content').scrollTop = 0;
                dom.query('.md-sidenav-content').scrollLeft = 0;

                dom.setStyle(dom.query('.md-sidenav-content'), 'overflow', 'hidden');
                dom.addClass(dom.query('.header'), 'fullscreen-header');
                dom.addClass(dom.query('.box[data-boxrid="'+ this.config.customData['rid'] +'"] .content'), 'fullscreen');
                this.sidebarService.fullScreenMode = true;
            }
        });
    }

    /**
     * Emit resize box event
     *
     * @param data - object data
     * {
     *  val - resize value
     *  type - resize direction(width, height)
     * }
     */
    emitResizeBox(data: Object) {
        let res: DashboardResizeConfig = <DashboardResizeConfig>{};
        res.type = data['type'];
        res.chart = this.chart;

        if (data['type'] == BoxResize.WIDTH) {
            res.width = data['val'];
            res.height = this.statusBoxHeight;

            this.statusBoxWidth = data['val'];
        }

        if (data['type'] == BoxResize.HEIGHT) {
            res.width = this.statusBoxWidth;
            res.height = data['val'];

            this.statusBoxHeight = data['val'];
        }

        this.resizeBox.emit(res);
    }

    /**
     * Emit remove box event
     */
    emitRemoveBox() {
        this.removeBox.emit();
    }

    /**
     * Emit edit box event
     */
    emitEditBox() {
        this.editBox.emit();
    }

    getBoxKindClass(kind: string): string {
        switch (kind) {
            case 'Feedback status':
                this.config.icon = 'bug_report';

                return 'feedback';

            case 'Profit status':
                this.config.icon = 'account_balance_wallet';

                return 'profit';

            case 'Orders status':
                this.config.icon = 'compare_arrows';

                return 'orders';

            case 'Users status':
                this.config.icon = 'accessibility';

                return 'users';
        }
    }
}
