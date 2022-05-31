public with sharing class CryptoPriceController {
    
    public CryptoPriceController() {
    }

    @AuraEnabled(cacheable=true)
    public static List<Map<string, string>> getLivePrices() {
        List<Map<string, string>> coinPrices = new List<Map<string, string>>();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();
        req.setEndpoint('https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=15&convert=USD');
        req.setMethod('GET');
        req.setHeader('X-CMC_PRO_API_KEY', 'yyye02cc-aaaa-4457-8214-xxxxxxxxxxxx');
        res = http.send(req);
        Map<string, object> responseMap = (Map<string, object>) JSON.deserializeUntyped(res.getbody());
        List<object> data = (List<object>) responseMap.get('data');
        Map<string, string> coinData;
        for(Integer i = 0; i < data.size(); i++) {
            Map<String, object> coin = (Map<String, object>) data[i];
            coinData = new Map<string, string>();
            coinData.put('name', (string)coin.get('name'));
            coinData.put('symbol', (string)coin.get('symbol'));
            Map<string, object> quote = (Map<string, object>) coin.get('quote');
            Map<string, object> usdQuote = (Map<string, object>) quote.get('USD');
            coinData.put('price', '$' +  Decimal.valueOf((double)usdQuote.get('price')).setScale(2));
            coinData.put('percent_change_24h', Decimal.valueOf((double)usdQuote.get('percent_change_24h')).setScale(2) + '%');
            coinPrices.add(coinData);
        }
        return coinPrices;
    }
}
