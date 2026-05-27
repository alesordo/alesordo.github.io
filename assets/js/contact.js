(function () {
    'use strict';

    window.addEventListener('load', function () {
        var form = document.getElementById('contact-form');

        if (!form) {
            return;
        }

        form.addEventListener('submit', function (event) {
            event.preventDefault();
            event.stopPropagation();

            if (!form.checkValidity() || hasHoneypotValue(form)) {
                form.classList.add('was-validated');
                return;
            }

            submitForm(form);
        }, false);
    }, false);

    function hasHoneypotValue(form) {
        return form.address && form.address.value.length > 0;
    }

    function submitForm(form) {
        var submitBtn = form.querySelector('button[name="submit"]');
        var endpoint = form.dataset.endpoint;
        var method = (form.dataset.method || 'GET').toUpperCase();
        var successUrl = form.dataset.successUrl || '/thanks';
        var failureUrl = form.dataset.failureUrl || '/failed';
        var originalText = submitBtn ? submitBtn.textContent : '';

        if (!endpoint) {
            redirect(failureUrl);
            return;
        }

        setButtonState(submitBtn, true, 'Sending...');

        var request = buildRequest(form, endpoint, method);
        var timeout = createTimeout(15000);

        fetch(request.url, {
            method: request.method,
            body: request.body,
            mode: 'no-cors',
            credentials: 'omit',
            signal: timeout.signal
        })
            .then(function () {
                redirect(successUrl);
            })
            .catch(function () {
                setButtonState(submitBtn, false, originalText || 'Send');
                redirect(failureUrl);
            })
            .finally(function () {
                timeout.clear();
            });
    }

    function buildRequest(form, endpoint, method) {
        var formData = new FormData(form);

        if (method === 'GET') {
            var params = new URLSearchParams(formData);
            var separator = endpoint.indexOf('?') === -1 ? '?' : '&';

            return {
                method: 'GET',
                url: endpoint + separator + params.toString(),
                body: undefined
            };
        }

        return {
            method: method,
            url: endpoint,
            body: formData
        };
    }

    function createTimeout(milliseconds) {
        if (!window.AbortController) {
            return {
                signal: undefined,
                clear: function () {}
            };
        }

        var controller = new AbortController();
        var timeoutId = window.setTimeout(function () {
            controller.abort();
        }, milliseconds);

        return {
            signal: controller.signal,
            clear: function () {
                window.clearTimeout(timeoutId);
            }
        };
    }

    function setButtonState(button, disabled, text) {
        if (!button) {
            return;
        }

        button.disabled = disabled;
        button.textContent = text;
    }

    function redirect(url) {
        window.location.href = url;
    }
})();
