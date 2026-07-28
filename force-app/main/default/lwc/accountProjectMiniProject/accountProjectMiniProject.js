import { LightningElement } from 'lwc';
import {
    createRecord,
    updateRecord,
    deleteRecord
} from 'lightning/uiRecordApi';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import ACCOUNT_OBJECT from '@salesforce/schema/Account';

export default class AccountProjectMiniProject extends LightningElement {

    recordId = '';
    name = '';
    isLoading = false;

    handleRecordId(event) {
        this.recordId = event.target.value;
    }

    handleName(event) {
        this.name = event.target.value;
    }

    get disableAction() {
        return !this.recordId;
    }

    handleCreate() {

        if (!this.name) {
            this.showToast('Error', 'Please enter Account Name.', 'error');
            return;
        }

        this.isLoading = true;

        createRecord({
            apiName: ACCOUNT_OBJECT.objectApiName,
            fields: {
                Name: this.name
            }
        })
            .then((result) => {

                this.recordId = result.id;

                this.showToast(
                    'Success',
                    'Account created successfully.',
                    'success'
                );
            })
            .catch((error) => {

                this.showToast(
                    'Error',
                    error.body?.message || 'Unable to create Account.',
                    'error'
                );
            })
            .finally(() => {
                this.isLoading = false;
            });

    }

    handleUpdate() {

        if (!this.recordId || !this.name) {
            this.showToast(
                'Error',
                'Record Id and Name are required.',
                'error'
            );
            return;
        }

        this.isLoading = true;

        updateRecord({
            fields: {
                Id: this.recordId,
                Name: this.name
            }
        })
            .then(() => {

                this.showToast(
                    'Success',
                    'Account updated successfully.',
                    'success'
                );
            })
            .catch((error) => {

                this.showToast(
                    'Error',
                    error.body?.message || 'Unable to update Account.',
                    'error'
                );
            })
            .finally(() => {
                this.isLoading = false;
            });

    }

    handleDelete() {

        if (!this.recordId) {
            this.showToast(
                'Error',
                'Please enter Record Id.',
                'error'
            );
            return;
        }

        this.isLoading = true;

        deleteRecord(this.recordId)
            .then(() => {

                this.showToast(
                    'Success',
                    'Account deleted successfully.',
                    'success'
                );

                this.handleReset();
            })
            .catch((error) => {

                this.showToast(
                    'Error',
                    error.body?.message || 'Unable to delete Account.',
                    'error'
                );
            })
            .finally(() => {
                this.isLoading = false;
            });

    }

    handleReset() {
        this.recordId = '';
        this.name = '';
    }

    showToast(title, message, variant) {

        this.dispatchEvent(
            new ShowToastEvent({
                title,
                message,
                variant
            })
        );

    }
}