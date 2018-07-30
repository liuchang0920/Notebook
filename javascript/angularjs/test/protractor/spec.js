
describe('protactor demo', function() {
    // it('should have a title', function() {
    //     browser.get('http://juliemr.github.io/protractor-demo/');

    //     expect(browser.getTitle()).toEqual('Super Calculator');
    // });

    // it('should add one and two', function() {
    //     browser.get('http://juliemr.github.io/protractor-demo/');
    //     element(by.model('first')).sendKeys(1);
    //     element(by.model('second')).sendKeys(2);
    //     element(by.id('gobutton')).click();

    //     expect(element(by.binding('latest')).getText()).toEqual('3');
        
    // });

    var firstNumber = element(by.model('first'));
    var secondNumber = element(by.model('second'));
    var goButton = element(by.id('gobutton'));
    var latestResult = element(by.binding('latest'));
    var history = element.all(by.repeater('result in memory'));
    
    function add(a, b) {
        firstNumber.sendKeys(a);
        secondNumber.sendKeys(b);
        goButton.click();
    }

    beforeEach(function() {
        browser.get('http://juliemr.github.io/protractor-demo/');

    });

    // it('should havea title', function () {

    // });

    // it('should read the value from an input', function() {
    //     firstNumber.sendKeys(1);
    //     expect(firstNumber.getAttribute('value')).toEqual('1');
    // });

    it('should have a history', function() {
        add(1, 2);
        add(3, 4);
        
        expect(history.count()).toEqual(2);

        add(5, 6);

        expect(history.count()).toEqual(3);
    });
});