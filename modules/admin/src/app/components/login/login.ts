import {Component, } from 'angular2/core';
import {ODatabaseService} from './../../../Service/OrientDB.service';
import {Router, RouterLink, ROUTER_DIRECTIVES} from 'angular2/router';
import {CORE_DIRECTIVES, FORM_DIRECTIVES} from 'angular2/common';
import {Cookie} from './cookie';
import {TranslateService, TranslatePipe} from 'ng2-translate/ng2-translate';

@Component({
    selector: 'login',
    providers: [],
    templateUrl: 'app/components/login/login.html',
    styleUrls: ['app/components/login/login.css'],
    directives: [RouterLink, CORE_DIRECTIVES, FORM_DIRECTIVES, ROUTER_DIRECTIVES],
    pipes: [TranslatePipe]
})

export class Login {
    constructor(public router?: Router, public translate?: TranslateService,
                public database?: ODatabaseService) {
    }

    authentication(login, password) {
        if (login && password) {
            this.database.open(login, password)
                .then(
                    (res) => {
                        console.log('Result: ', res);
                        document.cookie = 'rightWrite=true';
                        this.router.parent.navigate(['Navigation']);
                    }
                )
                .catch(
                    (err) => {
                        console.log('Error: ', err);
                        // delete cookie
                        document.cookie = 'rightWrite=true;expires=Mon, ' +
                            '01-Jan-2000 00:00:00 GMT';
                    }
                );
        } else {
            alert('Not filled fields!');
        }
    }

    ngOnInit() {
        this.database.init('http://localhost:3000/orientdb/smsc');
    }
}
