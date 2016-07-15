import {ROUTER_DIRECTIVES, RouteConfig} from '@angular/router-deprecated';
import {Component} from '@angular/core';
import {TranslatePipe, TranslateService} from 'ng2-translate/ng2-translate';
import {CustomersEditing} from './customers.edit';

require('./customers.scss');

@Component({
    selector: 'customers',
    template: require('./customers.html'),
    styleUrls: [],
    providers: [],
    directives: [ROUTER_DIRECTIVES],
    pipes : [TranslatePipe]
})

@RouteConfig([
    {path: '/edit/:id', component: CustomersEditing,
        name: 'CustomersEditGrid', useAsDefault: true}
])

export class Customers {

    constructor(public translate: TranslateService) {
    }

    ngOnInit() {
    }

}