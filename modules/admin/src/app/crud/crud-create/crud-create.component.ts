import { Component } from '@angular/core';
import { TranslateService } from 'ng2-translate/ng2-translate';
import { Router, ActivatedRoute } from '@angular/router';
import { CrudService } from '../crud.service';
import { Location } from '@angular/common';
import { BtnTypes } from '../dynamic-form/model/button-types';
import { FormPropertyModel } from '../model/form-property';

@Component({
    selector: 'crud-create',
    template: '<dynamic-form [btnName]="btnName" [columnDefs]="columnDefs"></dynamic-form>',
    styleUrls: [
        require('../common/style.scss')
    ],
    providers: [Location]
})

export class CrudCreateComponent {
    public columnDefs: Array<FormPropertyModel>;
    public btnName: BtnTypes = BtnTypes.CREATE;

    constructor(public translate: TranslateService,
                public crudService: CrudService,
                public router: Router,
                public route: ActivatedRoute,
                public location: Location) {
    }

    ngOnInit() {
        // sets path from root component
        this.crudService.setParentPath(this.route.parent.parent.snapshot.pathFromRoot);

        this.columnDefs = this.route.snapshot.data['create'];
    }

    ngOnDestroy() {
        this.crudService.multipleSelectValid = false;
        this.crudService.setModel({});
    }

    onSubmit() {
        this.crudService.createRecord(this.crudService.model,
            this.route.snapshot.params['className']);
    }

}
