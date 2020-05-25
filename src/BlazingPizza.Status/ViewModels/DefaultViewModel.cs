using System.Threading.Tasks;

namespace BlazingPizza.Status.ViewModels
{
	public class DefaultViewModel : MasterPageViewModel
    {
		public DefaultViewModel()
		{
		}

		public async override Task PreRender()
		{
			Context.RedirectToLocalUrl("/hc-ui");
			await base.PreRender();
		}
	}
}
