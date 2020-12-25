const STRATEGIES = {
    isEmpty(value, errorMsg) {
        return $.trim(value) === '' ?
            errorMsg : void 0
    },
    notEqual(value, anotherValue, errorMsg) {
        return value !== anotherValue ?
            errorMsg : void 0
    },
    notEqualToElem(value, elem, errorMsg) {
        return value !== elem.val() ?
            errorMsg : void 0
    },
    minLength(value, length, errorMsg) {
        return value.length < length ?
            errorMsg : void 0
    },
    maxLength(value, length, errorMsg) {
        return value.length > length ?
            errorMsg : void 0
    },
    betweenLength(value, minLength, maxLength, errorMsg) {
        return value.length < minLength || value.length > maxLength ?
            errorMsg : void 0
    },
    matchRegex(value, regex, errorMsg) {
        return !regex.test(value) ?
            errorMsg : void 0
    },
    // alphanumeric & underscore
    isGeneral(value, errorMsg) {
        return !/^\w+$/.test(value) ?
            errorMsg : void 0
    },
    isNumbers(value, errorMsg) {
        return !/^\d+$/.test(value) ?
            errorMsg : void 0
    },
    isWord(value, errorMsg) {
        return !/^[a-zA-Z]+$/.test(value) ?
            errorMsg : void 0
    },
    isAlnum(value, errorMsg) {
        return !/^[0-9a-zA-Z]+$/.test(value) ?
            errorMsg : void 0
    },
    isMoney(value, errorMsg) {
        return !/^(\d+(?:\.\d+)?)$/.test(value) ?
            errorMsg : void 0
    },
    isMobile(value, errorMsg) {
        return !/^(?:0|86|\+86)?1[3-9]\d{9}$/.test(value) ?
            errorMsg : void 0
    },
    isEmail(value, errorMsg) {
        // the regex is the same as that used in type="email" from W3C
        return !/^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/.test(value) ?
            errorMsg : void 0
    },
    isGeneralWithChinese(value, errorMsg) {
        return !/^[\u4e00-\u9FFF\w]+$/.test(value) ?
            errorMsg : void 0
    }
}

/** @class Validator representing the validator of an input item in the form */
class Validator {
    /**
     * Create a validator for a jQuery element.
     * @author SihenZhang
     * @constructor
     * @param elem {jQuery} - jQuery element
     * @param rules {Object[]} - validator rules
     * @param rules[].strategy {string} - the strategy that the rule will use
     * @param rules[].errorMsg {string} - if not validate, return the error message
     * @param [rules[].paramList] {Array} - the parameters of the rule
     */
    constructor(elem, rules) {
        this.elem = elem
        this.validationFuncs = []
        this.add(rules)
    }
    /**
     * Add rules for the validator.
     * @param rules {Object[]} - validator rules
     * @param rules[].strategy {string} - the strategy that the rule will use
     * @param rules[].errorMsg {string} - if not validate, return the error message
     * @param [rules[].paramList] {Array} - the parameters of the rule
     */
    add(rules) {
        for (const rule of rules) {
            this.validationFuncs.push(() => {
                let strategyParams = [this.elem.val()]
                if (rule.paramList) {
                    for (const param of rule.paramList) {
                        strategyParams.push(param)
                    }
                }
                strategyParams.push(rule.errorMsg)
                return STRATEGIES[rule.strategy].apply(this.elem, strategyParams)
            })
        }
    }
    /**
     * Validate the element value.
     * @returns {string|undefined} - If has no error message, return undefined, else return the error message
     */
    validate() {
        for (let validatorFunc of this.validationFuncs) {
            const errorMsg = validatorFunc()
            if (errorMsg) {
                return errorMsg
            }
        }
    }
}

jQuery.fn.extend({
    /**
     * Validation the jQuery element using Bootstrap 4 class
     * @param validator {Validator} - validator of the element
     * @param [noValid] {boolean} - if true, will not add/remove 'is-valid' class for the element
     * @return {boolean} - if has no error message, will remove 'is-invalid' class and return true, else will add 'is-invalid' class and return false
     */
    validation: function (validator, noValid) {
        const errorMsg = validator.validate()
        const $elem = this.parent().hasClass('input-group') ? this.add(this.parent()) : this
        if (errorMsg) {
            $elem.addClass('is-invalid')
            if (!noValid) {
                $elem.removeClass('is-valid')
            }
            $elem.siblings('.invalid-feedback').text(errorMsg)
            return false
        } else {
            $elem.removeClass('is-invalid')
            if (!noValid) {
                $elem.addClass('is-valid')
            }
            $elem.siblings('.invalid-feedback').text('')
            return true
        }
    }
})

jQuery.extend(
    {
        /**
         * Get specific parameter from the url.
         * @param name {string} - the name of the parameter
         * @param [defaultValue] {string} - if don't have the parameter, it will return this
         * @return {string|null} - return the parameter, if don't have, return null or the default value
         */
        getUrlParam : function (name, defaultValue) {
            const regex = new RegExp('(^|&)' + name + '=([^&]*)(&|$)')
            const result = location.search.substr(1).match(regex)
            if (result != null) {
                return decodeURI(result[2])
            } else {
                if (defaultValue !== undefined) {
                    return defaultValue
                } else {
                    return null
                }
            }
        },
        /**
         * Set parameter from the url.
         * @param name {string} - the name of the parameter
         * @param value {string} - the value of the parameter
         */
        setUrlParam : function (name, value) {
            const url = location.href.toString()
            const regex = new RegExp('(' + name + '=)([^&]*)')
            const newUrl = url.replace(regex, name + '=' + value)
            location.replace(newUrl)
        }
    }
)