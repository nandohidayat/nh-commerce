export default class Index {
    static index(req, res) {
        res.render('default', {
            title: 'Toko Buku Bu Ratna',
            message: 'Welcome :)',
            currentPath: req.baseUrl,
        });
    }
}
